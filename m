Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205F606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HINXr5jg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7OZ-0005Q8-Ub; Wed, 28 Oct 2026 13:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM7Nb-0004qS-3R
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM7NY-0004zz-3K
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793208239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFcAr6/aE50M+7rVT8l3cEh7YIP/JkjqUfA1WCLxqFY=;
 b=HINXr5jgyTL7LsnqB5WpUrJ5mDj7rQSQvIKXFFhmINU38yOkMsMyEpVk0honZjAZkK8B5u
 7+v+SenMfUJfotQJGIHes5ElPRRffRh01UblDtiuLefWFLeebc6YDDEw+LWQCSG7s7qpMA
 fU8pOkEBMuhGMuausQ/5SeKwFyRhvXo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-8TKwqKiqMs2m8bjFoFi9uw-1; Wed,
 28 Oct 2026 13:23:51 -0400
X-MC-Unique: 8TKwqKiqMs2m8bjFoFi9uw-1
X-Mimecast-MFC-AGG-ID: 8TKwqKiqMs2m8bjFoFi9uw_1793208230
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DF771800597; Wed, 28 Oct 2026 17:23:50 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09137195608D; Wed, 28 Oct 2026 17:23:48 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/2] qga/vss: fix provider handling of snapshots
Date: Wed, 28 Oct 2026 19:23:42 +0200
Message-ID: <20261028172342.96036-3-kkostiuk@redhat.com>
In-Reply-To: <20261028172342.96036-1-kkostiuk@redhat.com>
References: <20261028172342.96036-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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
---
 qga/vss-win32/install.cpp   |   1 +
 qga/vss-win32/provider.cpp  | 200 +++++++++++++++++++++++++++++++++++-
 qga/vss-win32/requester.cpp |  26 +++++
 3 files changed, 226 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 431fcd1cbe..df00588c92 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -422,6 +422,7 @@ STDAPI COMRegister(void)
     chk(put_Value(pObj, L"Authentication",                 short(6)));
     chk(put_Value(pObj, L"AuthenticationCapability",       short(2)));
     chk(put_Value(pObj, L"ImpersonationLevel",             short(2)));
+    /* NT-service-hosted apps have ConcurrentApps=1 enforced */
     chk(pApps->SaveChanges(&n));
 
     /* The app should be deleted if something fails after SaveChanges */
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 1c8eb236e5..bbc30dd57d 100644
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
@@ -138,6 +143,170 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumObject **ppenum)
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
 
@@ -266,7 +435,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lContext)
 STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
     VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
 {
-    return S_OK;
+    return qga_vss_registry.GetProperties(SnapshotId, pProp);
 }
 
 STDMETHODIMP CQGAVssProvider::Query(
@@ -286,6 +455,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
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
@@ -295,6 +485,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapshot(
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
 
@@ -411,6 +608,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitSnapshots(VSS_ID SnapshotSetId)
 
 STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
 {
+    qga_vss_registry.RemoveSet(SnapshotSetId);
     return S_OK;
 }
 
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 1b0155c691..565eefcfb2 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties pVssFreeSnapshotProperties;
 static struct QGAVSSContext {
     IVssBackupComponents *pVssbc;  /* VSS requester interface */
     IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot operation */
+    VSS_ID idSnapshotSet;          /* snapshot set created for this cycle */
     HANDLE hEventFrozen;           /* notify fs/writer freeze from provider */
     HANDLE hEventThaw;             /* request provider to thaw */
     HANDLE hEventTimeout;          /* notify timeout in provider */
@@ -116,6 +117,7 @@ static void requester_cleanup(void)
         vss_ctx.pVssbc->Release();
         vss_ctx.pVssbc = NULL;
     }
+    vss_ctx.idSnapshotSet = GUID_NULL;
     vss_ctx.cFrozenVols = 0;
     qga_debug_end;
 }
@@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
         err_set(errset, hr, "failed to start snapshot set");
         goto out;
     }
+    vss_ctx.idSnapshotSet = guidSnapshotSet;
 
     if (mountpoints) {
         PWCHAR volume_name_wchar;
@@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
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
2.54.0 (Apple Git-157)


