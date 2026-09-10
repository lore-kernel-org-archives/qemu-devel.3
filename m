Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E584EC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4owk-0002XR-A9; Thu, 10 Sep 2026 20:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lkz-0001lX-JL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lkp-0006TD-Ps
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GnRjJ65SGrC9am8hi9r7ANKDtkiUG6pnQWAw9MHk3fY=;
 b=PG40q3MQ8ViwKV7hADhs1anyGOVwl7JfQtzST5uyn8xDnWPWBh2L1pl9edfkIrr484bHb8
 qFMS6L5nAk46uyNSJmOvguKjvxCrThGBTM2gUitaW5KKLmufID11pgs9PT4ms0ag8T61Y/
 X44n+5jk6lPSshtHNrLsHJKf1HYjwoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-q8bAevDUOVebB6VvTWsclg-1; Thu, 10 Sep 2026 16:13:08 -0400
X-MC-Unique: q8bAevDUOVebB6VvTWsclg-1
X-Mimecast-MFC-AGG-ID: q8bAevDUOVebB6VvTWsclg_1789071187
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-484362cb000so119506f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071187; x=1789675987; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GnRjJ65SGrC9am8hi9r7ANKDtkiUG6pnQWAw9MHk3fY=;
 b=Uux0OJb0f+qKoIIDfC6U142jCsY9Z/1ZobTHo8IF9RN1GS2le3o4244Sp0nCsyWYLc
 CLyRXgHd5uRmykP2uk42lDv9k7xR/XvaBOp6vVUNTdPeaiTdMP74oWBS1NqiPdSRwFW6
 W+UJn2wC0WRx+oIoIwxRGHIC2LoM3U9j17gUgqI4RQSq1go0eu4M8gCq66CHQLF9KchE
 VI1zo1UKO9NzvGl5m2DdB/CXCy5O6ja9P204pMOMXVVMgSYCVkhHJszqntIcTXToc+pG
 bG+Bf3nBjhZU309NL85rU4y3RuHLUHdSjQ1b57K2chSnXkb851rReOOqU4IRGHnRwuz+
 5Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071187; x=1789675987;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GnRjJ65SGrC9am8hi9r7ANKDtkiUG6pnQWAw9MHk3fY=;
 b=q+PbHK9Qpa4sEY/uQ/+vjsgPFyVPF/T7LW7FOe2p6egeLRx6wbypL4vEi++Ckohxnw
 uqVT0bJZVafs+W6rcCOJnrALQ0u7W3/FiMRd5gmqoqyqWWeoOSCSkHNWGRsX45jeyFBh
 IQL1sLEdfiSksDzXoIIoIMUtIgv+PUs/n9NLmwzh7SxFzPIGHoiVCBigPHK5DrNq4yb0
 gkPTcRE+ishX/YSTdAkGwJBiAxBCumAo0t+L9qpdXxiTU+36WlWD8YfJvadiAhsLsNnq
 3FEJJupjfwuvbfsqRJ7U30KcviFbQdSk0DFdBkt8cOqmSeM72aR7+EPQWXW7muGRtiqR
 TVQQ==
X-Gm-Message-State: AFuF++ncULBNeyp6QDn9xmeZuHJYeUhbQLlYbPIBVq5V5tZWnqOAFLMQ
 bUJDnUSl7ziDMuYo0ECvh2WE3DrHrACaPjvo+X2q/FlaUIpznYVqQbnsSA0TIJyj+vXrAk6HzRH
 DLhI3dN4n1QgDRVQP9+B+xUWNKiPwmxlIvckokKD5WkYkPI0KvuNsK7gxDwHBjEi6X5V5TrMSmY
 e9dBw0FpEKVAOQ8UyAwhHm3fpd1ItXNn8Bag==
X-Gm-Gg: AYBFou2yZQHQTh7DaN3qRXv16FlMLPKISPdR/7mptJO7om266fx6DRAgPWe9lwyjKrx
 iaJ/fhLwB15DiBRYtXb2YnjXf4jWABi4F5ckyohc41k4K8rfjzE+6GoUacXAdvnmdc7VIm+ES3+
 ZeH6eBeUFNNQ8U+f6qpS8qyo6k4yWIi6rTViPRAqbc9oGoMqPh+frxoxfNCxlkbmbOytFAm7/4+
 1ANmmkvfJFNTWUqKXLnLpf7sqGWjC925PTh6LAV+2FfrK5++gVuComd3vX/7OMSaNVP4fEngwNo
 IEsrt9CrNl0nehWeKJ6H+qpMwaHsEmH6aVHr83Izv7Ok44FuLCAglo65DfYCd75kahCbghiUUTP
 gOW75rgleU4N2G9/skEPOriI=
X-Received: by 2002:a05:6000:178b:b0:485:8413:5272 with SMTP id
 ffacd0b85a97d-486e0f8e741mr8013175f8f.26.1789071187004; 
 Thu, 10 Sep 2026 13:13:07 -0700 (PDT)
X-Received: by 2002:a05:6000:178b:b0:485:8413:5272 with SMTP id
 ffacd0b85a97d-486e0f8e741mr8013110f8f.26.1789071186445; 
 Thu, 10 Sep 2026 13:13:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm847945f8f.9.2026.09.10.13.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 39/90] tests/bios-tables-test: Exclude CEDT.cxl for the CFMW
 restriction change
Message-ID: <1bd49555d4287049d06ee0e319ffdf2be41fd6f3.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Davidlohr Bueso <dave@stgolabs.net>

The next patch changes the default CXL Fixed Memory Window restrictions,
dropping Back-Invalidate.  Add CEDT.cxl to the allowed-diff list so the
comparison passes until the expected blob is regenerated.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-2-dave@stgolabs.net>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b4646b5b31 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
MST


