Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B98606A8BC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=fE4Bkc9u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IR-0000bX-UC; Mon, 16 Nov 2026 15:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IP-0000Vo-U7; Mon, 16 Nov 2026 15:27:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IM-0001Nb-Um; Mon, 16 Nov 2026 15:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=iEXtjwPpsmn1rgjjRjI3lFQqWTkyDCFOR/F9d0XzHsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fE4Bkc9uyIC6Nzs94y5CU3bF49G9M+3uJNXgvJW03O7etiJElV8rPmeInGyjQxbPp
 n0WgdQ58Bfb7B4vKGgqYOPFwCf/StuNSdOHZ2+No58H5wI6/VU/HSsa1Fq9fB2WNN3
 zrMXMNhA9xyydolPl6DdsigtX8A8Qx6U/fQRU0H/eAihBq7bhNmFKV0uL9GBbmkL+3
 rMyzbT80wt1hnO6CPgG2TEsHxxvjigAM1sE5jxMUzTXWVcaTe6yjfWyLchVa72BkOh
 FzftDYAxQR9rcvSNooRHQIYh56c+lIeytxmImAtIUdc9QZx27bPRPqqZzA2AnH+kld
 KTatkavuyZglA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0389A1E71A6;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F3B7545FBD2;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9AA4DB8E68; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 17/63] qga/vss: fix provider handling of snapshots
Date: Mon, 16 Nov 2026 23:24:56 +0300
Message-ID: <20261116202554.535325-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit 374f4676788c, the provider's GetSnapshotProperties()
returns S_OK for any snapshot ID without filling in the properties.  VSS
consults every registered provider when a requester looks up a snapshot,
so lookups of snapshots owned by other providers now succeed with an
all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.g.
Veeam: "Original volume name is not specified for the shadow (shadow
volume id: '{00000000-0000-0000-0000-000000000000}')".

Simply reverting is not an option: 374f4676788c switched to S_OK because
returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga's own
snapshot sets. The provider must answer for its own snapshots only. It
does not create real shadow copies, but it does take part in the
snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot IDs
received in BeginPrepareSnapshot(), return their required properties,
and return VSS_E_OBJECT_NOT_FOUND for anything else. Fill every required
VSS_SNAPSHOT_PROP member except the exposed name and path, which are
optional. The snapshot device object is an empty string because the
host-side snapshot has no guest-visible device.

Entries are dropped when VSS deletes the snapshots or the set, or when
the set is aborted (AbortSnapshots()).

COM+ may hand out several CQGAVssProvider instances (and serve several
client processes), so this registry is module-global. It is per-process
by design and safe because the COM+ application is hosted by a single NT
service (see CreateServiceForApplication() in install.cpp): COM+ forbids
pooling and recycling for service-hosted applications, so exactly one
surrogate process ever hosts the provider.

On the requester side, the snapshot set is created in the persistent
VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw
cycle and may keep querying providers about it. The provider registry
does not outlive the cycle (requester_thaw() stops the hosting service,
and the provider process with it), so later queries would get "not
found" for a set VSS still believes exists. Make requester_thaw() delete
the snapshot set explicitly at the end of the cycle, whatever its
outcome (including BackupComplete() failure and aborted snapshot sets).
A failure to delete is only logged, since the guest filesystems have
already been thawed.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4584
Buglink: https://redhat.atlassian.net/browse/RHEL-250662
Fixes: 374f4676788c ("qga: Fix VSS provider GetSnapshotProperties return value")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261027160606.2668607-2-marcandre.lureau@redhat.com
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit e8953bf0be6f4399d1333f92db41e4d146f754af)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5b7a8e9bc52..3b3693fc841 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -313,6 +313,7 @@ STDAPI COMRegister(void)
     chk(put_Value(pObj, L"Authentication",                 short(6)));
     chk(put_Value(pObj, L"AuthenticationCapability",       short(2)));
     chk(put_Value(pObj, L"ImpersonationLevel",             short(2)));
+    /* NT-service-hosted apps have ConcurrentApps=1 enforced */
     chk(pApps->SaveChanges(&n));
 
     /* The app should be deleted if something fails after SaveChanges */
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 2b5c6f8e8ec..192188edf3e 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -11,6 +11,11 @@
  */
 
 #include "qemu/osdep.h"
+
+#include <vector>
+#include <algorithm>
+#include <string>
+
 #include "vss-common.h"
 #include "vss-debug.h"
 #ifdef HAVE_VSS_SDK
@@ -136,6 +141,170 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumObject **ppenum)
     return E_NOTIMPL;
 }
 
+static VSS_PWSZ qga_vss_strdup(const WCHAR *value)
+{
+    size_t len = (wcslen(value) + 1) * sizeof(WCHAR);
+    VSS_PWSZ str = (VSS_PWSZ)CoTaskMemAlloc(len);
+
+    if (str) {
+        memcpy(str, value, len);
+    }
+    return str;
+}
+
+static VSS_PWSZ qga_vss_strdup(const std::wstring &value)
+{
+    return qga_vss_strdup(value.c_str());
+}
+
+static VSS_TIMESTAMP qga_vss_timestamp(void)
+{
+    FILETIME ft;
+    ULARGE_INTEGER value;
+
+    GetSystemTimeAsFileTime(&ft);
+    value.LowPart = ft.dwLowDateTime;
+    value.HighPart = ft.dwHighDateTime;
+    return value.QuadPart;
+}
+
+/* Registry of the snapshot IDs for this provider */
+class QGAVssSnapshotRegistry
+{
+public:
+    bool Track(VSS_ID set_id, VSS_ID snapshot_id,
+               VSS_PWSZ volume_name, LONG context);
+    HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP *prop) const;
+    LONG RemoveSet(VSS_ID set_id); /* returns how many were removed */
+    bool Remove(VSS_ID snapshot_id);
+
+private:
+    struct Entry {
+        VSS_ID set_id;
+        VSS_ID snapshot_id;
+        std::wstring volume_name;
+        LONG context;
+        VSS_TIMESTAMP timestamp;
+    };
+
+    std::vector<Entry> m_entries;
+    mutable SRWLOCK m_lock = SRWLOCK_INIT;
+};
+
+static QGAVssSnapshotRegistry qga_vss_registry;
+
+bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot_id,
+                                   VSS_PWSZ volume_name, LONG context)
+{
+    bool ok;
+
+    AcquireSRWLockExclusive(&m_lock);
+    try {
+        m_entries.push_back(Entry { set_id, snapshot_id, volume_name,
+                                    context, qga_vss_timestamp() });
+        ok = true;
+    } catch (...) {
+        ok = false;
+    }
+    ReleaseSRWLockExclusive(&m_lock);
+    return ok;
+}
+
+HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,
+                                              VSS_SNAPSHOT_PROP *prop) const
+{
+    HRESULT hr = S_OK;
+    VSS_PWSZ device = NULL, original = NULL;
+    VSS_PWSZ originating = NULL, service = NULL;
+
+    AcquireSRWLockShared(&m_lock);
+    auto it = std::find_if(m_entries.begin(), m_entries.end(),
+        [&](const Entry &e) {
+            return IsEqualGUID(e.snapshot_id, snapshot_id);
+        });
+    if (it == m_entries.end()) {
+        hr = VSS_E_OBJECT_NOT_FOUND;
+        goto out;
+    }
+
+    {
+        const Entry &e = *it;
+        WCHAR machine[256] = L"";
+        DWORD machine_size = ARRAYSIZE(machine);
+
+        if (!GetComputerNameExW(ComputerNameDnsFullyQualified, machine,
+                               &machine_size)) {
+            *machine = L'\0';
+        }
+
+        device = qga_vss_strdup(L"");
+        original = qga_vss_strdup(e.volume_name);
+        originating = qga_vss_strdup(machine);
+        service = qga_vss_strdup(machine);
+        if (!device || !original || !originating || !service) {
+            hr = E_OUTOFMEMORY;
+            goto out;
+        }
+
+        memset(prop, 0, sizeof(*prop));
+        prop->m_SnapshotId = e.snapshot_id;
+        prop->m_SnapshotSetId = e.set_id;
+        prop->m_lSnapshotsCount = std::count_if(m_entries.begin(),
+            m_entries.end(), [&](const Entry &o) {
+                return IsEqualGUID(o.set_id, e.set_id);
+            });
+        prop->m_pwszSnapshotDeviceObject = device;
+        prop->m_pwszOriginalVolumeName = original;
+        prop->m_pwszOriginatingMachine = originating;
+        prop->m_pwszServiceMachine = service;
+        prop->m_ProviderId = g_gProviderId;
+        prop->m_lSnapshotAttributes = e.context;
+        prop->m_tsCreationTimestamp = e.timestamp;
+        prop->m_eStatus = VSS_SS_CREATED;
+
+        device = original = originating = service = NULL;
+    }
+
+out:
+    CoTaskMemFree(device);
+    CoTaskMemFree(original);
+    CoTaskMemFree(originating);
+    CoTaskMemFree(service);
+    ReleaseSRWLockShared(&m_lock);
+    return hr;
+}
+
+LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)
+{
+    LONG removed;
+
+    AcquireSRWLockExclusive(&m_lock);
+    auto it = std::remove_if(m_entries.begin(), m_entries.end(),
+        [&](const Entry &e) {
+            return IsEqualGUID(e.set_id, set_id);
+        });
+    removed = m_entries.end() - it;
+    m_entries.erase(it, m_entries.end());
+    ReleaseSRWLockExclusive(&m_lock);
+    return removed;
+}
+
+bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)
+{
+    bool found;
+
+    AcquireSRWLockExclusive(&m_lock);
+    auto it = std::find_if(m_entries.begin(), m_entries.end(),
+        [&](const Entry &e) {
+            return IsEqualGUID(e.snapshot_id, snapshot_id);
+        });
+    found = it != m_entries.end();
+    if (found) {
+        m_entries.erase(it);
+    }
+    ReleaseSRWLockExclusive(&m_lock);
+    return found;
+}
 
 /* QGAVssProvider */
 
@@ -263,7 +432,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContext)
 STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
     VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
 {
-    return S_OK;
+    return qga_vss_registry.GetProperties(SnapshotId, pProp);
 }
 
 STDMETHODIMP CQGAVssProvider::Query(
@@ -283,6 +452,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
     VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType,
     BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID *pNondeletedSnapshotID)
 {
+    LONG deleted = 0;
+
+    switch (eSourceObjectType) {
+    case VSS_OBJECT_SNAPSHOT:
+        if (qga_vss_registry.Remove(SourceObjectId)) {
+            deleted = 1;
+        }
+        break;
+    case VSS_OBJECT_SNAPSHOT_SET:
+        deleted = qga_vss_registry.RemoveSet(SourceObjectId);
+        break;
+    default:
+        break;
+    }
+
+    if (deleted > 0) {
+        *plDeletedSnapshots = deleted;
+        *pNondeletedSnapshotID = GUID_NULL;
+        return S_OK;
+    }
+
     *plDeletedSnapshots = 0;
     *pNondeletedSnapshotID = SourceObjectId;
     return S_OK;
@@ -292,6 +482,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapshot(
     VSS_ID SnapshotSetId, VSS_ID SnapshotId,
     VSS_PWSZ pwszVolumeName, LONG lNewContext)
 {
+    if (!pwszVolumeName) {
+        return E_INVALIDARG;
+    }
+    if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,
+                                pwszVolumeName, lNewContext)) {
+        return E_OUTOFMEMORY;
+    }
     return S_OK;
 }
 
@@ -408,6 +605,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitSnapshots(VSS_ID SnapshotSetId)
 
 STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
 {
+    qga_vss_registry.RemoveSet(SnapshotSetId);
     return S_OK;
 }
 
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 493ecd57172..bf62eceef92 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -50,6 +50,7 @@ static t_VssFreeSnapshotProperties pVssFreeSnapshotProperties;
 static struct QGAVSSContext {
     IVssBackupComponents *pVssbc;  /* VSS requester interface */
     IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot operation */
+    VSS_ID idSnapshotSet;          /* snapshot set created for this cycle */
     HANDLE hEventFrozen;           /* notify fs/writer freeze from provider */
     HANDLE hEventThaw;             /* request provider to thaw */
     HANDLE hEventTimeout;          /* notify timeout in provider */
@@ -114,6 +115,7 @@ static void requester_cleanup(void)
         vss_ctx.pVssbc->Release();
         vss_ctx.pVssbc = NULL;
     }
+    vss_ctx.idSnapshotSet = GUID_NULL;
     vss_ctx.cFrozenVols = 0;
     qga_debug_end;
 }
@@ -400,6 +402,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         err_set(errset, hr, "failed to start snapshot set");
         goto out;
     }
+    vss_ctx.idSnapshotSet = guidSnapshotSet;
 
     if (mountpoints) {
         PWCHAR volume_name_wchar;
@@ -625,6 +628,29 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
         err_set(errset, hr, "failed to do snapshot set");
     }
 
+    /*
+     * The snapshot set is created in VSS_CTX_APP_ROLLBACK context, so
+     * it is persistent: if it was committed, VSS keeps it (and keeps
+     * querying providers about it) until it is explicitly deleted. The
+     * freeze/thaw cycle is over whatever the outcome above, so delete
+     * it now. Failure is not fatal here, only log it.
+     */
+    {
+        LONG lDeletedSnapshots = 0;
+        VSS_ID idNonDeletedSnapshot;
+        HRESULT hrDelete;
+
+        hrDelete = vss_ctx.pVssbc->DeleteSnapshots(vss_ctx.idSnapshotSet,
+                                                   VSS_OBJECT_SNAPSHOT_SET,
+                                                   TRUE,
+                                                   &lDeletedSnapshots,
+                                                   &idNonDeletedSnapshot);
+        if (FAILED(hrDelete)) {
+            qga_debug("failed to delete snapshot set after thaw,"
+                      " hr=0x%08lx", hrDelete);
+        }
+    }
+
     if (err_is_set(errset)) {
         vss_ctx.pVssbc->AbortBackup();
     }
-- 
2.47.3


