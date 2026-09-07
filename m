Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702D2C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wvm-0007Qs-Bb; Mon, 07 Sep 2026 06:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvc-0007Q9-0b
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wva-0007xT-Cn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQnp3Mz1B09gp9VQlo2nPfiEstnHQLr+FEq8i0YUZwo=;
 b=P4fIygROJtKqa7CueRkDRAJU+mIlYxRB9FzjbRxqFATU8RNKTa+uvqR2D6iW1Qo46NkRmT
 zyqubTL0E+1ipxMVuMJROlE+dxpwJp2W7Jp4JZFevtfzP/IMbvkMJODGlHhLsO8SrDfg/r
 xU8WWVwYntpNsyWuTWkmaSxDygYjYnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-UEUI-p1bME6vzF4kmhGVbA-1; Mon,
 07 Sep 2026 06:50:16 -0400
X-MC-Unique: UEUI-p1bME6vzF4kmhGVbA-1
X-Mimecast-MFC-AGG-ID: UEUI-p1bME6vzF4kmhGVbA_1788778215
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BFB1800DA1; Mon,  7 Sep 2026 10:50:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71FBC180034F; Mon,  7 Sep 2026 10:50:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:00 +0400
Subject: [PATCH 02/17] qga/vss-win32: fix race condition in COM Release()
 methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-2-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gCx/Di7WKMkbWKj6aE6B9CpxBklB9tL44A3DelTcsfw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjCeLijl9csgdzCW5SJS1zE9PzaABsvPZdM
 W97V/g33BOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5fIXEACnA72mc4xx7Xc+Vm81PQcD3OEmS7ZVMraKDNmaoT/3kD5X+TmQgTXk4ddtQgJVkT11OKI
 0cUIHFqRX8aSsOZHjc3sdtp47kZrgvzz2fOyglzNgwgjXLx7gXiLGOPs8uhHCBDs2/CbKxljfHd
 WV/E3s9KgjTmDglIy07FEBlMly2+AmKvSONsZGrpL+SsZVtU0xg4ULWb+KgP1o609shQYVYppJv
 F58H0jOBWKxBYE1ISH6BcD3EicexNB5fK49/Ci4/UWioktDHllQE66Vq5UXvrqWXOU65ROTF3/M
 MY5vtQwgnsw0wkENO+wxYc/rDQ9T0n+i4CxUVLJcQv8ceqoT09uqfugb1n2sgrgcBjdnrDSrzMm
 TDf+o0LKlgOKkr5vxiyU0r76WHC3qEv3kvI9siqg0CrLhG9EoZ0nNErg8Rth9CYPUgHzfWJQxoJ
 4nOd0K+6MnXv5OZmwyiZJFkE0a7b0hLajW394ITP43j/hIc3KIuj5MOuY/S+O+13MwaaPA7oUyJ
 NzwHnQI8QYGwXfSxhlXDACZTADk/32vErLtp/vja8lXb5Xc1AYLynZLp+OH5LopvgKpjU6p9bTe
 jsXRl/k0ylr6tjqIsbGFMxPjothO2GP5W2+MjNj6SnLYsReerg9mlyO8ilm0vYuI26v0qDOXqs4
 jcaNT4SmZIza4rg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All three Release() implementations checked the member m_nRefCount
after InterlockedDecrement instead of using the local return value.
In a multi-threaded context (vssvc), two threads decrementing
concurrently could both read m_nRefCount as 0 and double-free.

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/provider.cpp | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index 2b5c6f8e8ecd..79906dcc24ae 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -108,7 +108,7 @@ STDMETHODIMP_(ULONG) CQGAVSSEnumObject::AddRef()
 STDMETHODIMP_(ULONG) CQGAVSSEnumObject::Release()
 {
     long nRefCount = InterlockedDecrement(&m_nRefCount);
-    if (m_nRefCount == 0) {
+    if (nRefCount == 0) {
         delete this;
     }
     return nRefCount;
@@ -244,7 +244,7 @@ STDMETHODIMP_(ULONG) CQGAVssProvider::AddRef()
 STDMETHODIMP_(ULONG) CQGAVssProvider::Release()
 {
     long nRefCount = InterlockedDecrement(&m_nRefCount);
-    if (m_nRefCount == 0) {
+    if (nRefCount == 0) {
         delete this;
     }
     return nRefCount;
@@ -477,7 +477,7 @@ STDMETHODIMP_(ULONG) CQGAVssProviderFactory::AddRef()
 STDMETHODIMP_(ULONG) CQGAVssProviderFactory::Release()
 {
     long nRefCount = InterlockedDecrement(&m_nRefCount);
-    if (m_nRefCount == 0) {
+    if (nRefCount == 0) {
         delete this;
     }
     return nRefCount;

-- 
2.55.0.543.g5ebe2ebe4ea8


