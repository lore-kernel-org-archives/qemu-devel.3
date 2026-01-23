Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95FBD74EE2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIp8-0001L8-4h; Fri, 23 Jan 2026 10:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInY-00078T-1d
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:14 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInU-000383-NK
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:07 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so2028365f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769181003; x=1769785803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yGwNzjlczVKCMAyj5rVvNgbSDpwbzU8o5quzCmk6erU=;
 b=pfXdrGX3bHgW2A8ykwCIxXqMSlz7HVFq/LhPxejiAXp0PQj0GGDOGu55iPTU+CwK17
 TVXdgGUD/htopV0R0mb/V21tEajzgSKSzu8jFm8pnRkLGHLiC0ze71++ZtDl3lFLmAtF
 DcOEQD90r3L/gK6T0pmgieSbKfmO/YBzVEHFJYp9lU7w5QWLUtL88u5PyiLWXEHLthVR
 iXDkTD0WA3qOnKTsknTuZIfSOpcsnmPeKGzMS0m4T8jIa1eEtjOGm5k5e/6OMo8GMwep
 RkaLa8Xe6h8BRqRSGxvTkez9JxY5R0pX0Fdb9ibErM92SAh+THtX5PMuP49azufN7Vi9
 APDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181003; x=1769785803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yGwNzjlczVKCMAyj5rVvNgbSDpwbzU8o5quzCmk6erU=;
 b=AoMmA/iZSn8fntlIlheRFYdQeLSMa+4G/y+6lCJMaEH8ht6nKPQ1maUszSUiMr2/ae
 CiuzA0cZRBhCPAZUOkQNbwu4dQGu8Xi6kL7bz/O8+BV18SPYHTqdajJrIMD1CyE+E8pt
 5UIngxl+sbSIFH4A3U8bATCi8vpylE6xRfXAN5B+/baw9OvQfwh9g0dLGAatHNt2HvCy
 y26sZNNaN/cCP0Q6l1Ylr4GnxUPxWlCCGHJe8csMZtg4O0iP4upU/Bjnrq7o9rZjcz3Q
 7J7JKiMleuJO5SGczJX/HYdP01yXKevC+kXKpYFeVfcNKU3Iz/924Hwe2gzdu/4PqCBo
 UKAw==
X-Gm-Message-State: AOJu0YwaeRpmS2oFduqaccjssqqrQvsreYND7IeQWj/D7uLVqfZ0wxNv
 9fkZ8bul/+nKpj4Q46z7UrEHa6Cc04sY0g3sdG57+pkfGTdcNc2W1xWzy6jaEBv4aHKntMq0I1P
 K8myuV4g=
X-Gm-Gg: AZuq6aK3zycJ1V/CfGRhFs6FOWw5d8WPSlwDH4lfZWurHYZHmmA4ZiA66z/l6J6pheQ
 nhw1oQ29WCy/EXeLLjVoFFkuU/amoXAT+Janj4qyhIBfgjBAR0NzHmJEHc7A2eONkqD/fNFpA72
 sagmsHTjRTA+001AYTy0EbwHpu+bJyL9W4FlvxC1HiJOnly1uxN4RmyukDidA0gxWbIX+t1037G
 SqYtr7NlvElXaUQHZiaDVpEPpG38ETf29xQDBuZvISgYFP2zc6L76TZKmHsz6x9jR4Oe2l+z7RP
 CSpXKEizXgRa6ZqP8MpkRD7UIJfHdqhkqld2C9QTKs+K6oKXlGezTUisQBr06XFSRVq3Es5kA+7
 fCKU4KuRxdj69l3pn6rvF2STV6Sjo3ua3wkDg5SNxYDQFVKhklyqjuWCaafbM5Ff/5Hhj94fAdR
 c6g/+1m/4TfjOlaDbnjFsZ2k46aoXdzTqgskhT9vO2eNzYcbm1AD3T
X-Received: by 2002:a05:6000:2211:b0:435:9691:d525 with SMTP id
 ffacd0b85a97d-435b1588264mr5100058f8f.13.1769181002929; 
 Fri, 23 Jan 2026 07:10:02 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.10.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:10:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/22] qemu-options.hx: Improve formatting in colo-compare docs
Date: Fri, 23 Jan 2026 15:09:40 +0000
Message-ID: <20260123150941.1877768-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The colo-compare option documentation has some formatting issues: it
uses a "@var{...}" syntax which is not used elsewhere and which is
rendered literally into the HTML documentation.  The bare "@" sign
also results in an unintended 'mailto:' hyperlink.

Rewrite this into the style we seem to use most in the rest of
the command line options, where an option which takes an argument
is written as "my-option=<thing>".

We take the opportunity to make the documentation a little clearer
by splitting up the long paragraph and using preformatted-text
markup for the names of the suboptions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260115142629.665319-5-peter.maydell@linaro.org
---
 qemu-options.hx | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 862b6c7661..bd014a3244 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5972,22 +5972,31 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
 
-    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}][,max_queue_size=@var{size}]``
-        Colo-compare gets packet from primary\_in chardevid and
-        secondary\_in, then compare whether the payload of primary packet
-        and secondary packet are the same. If same, it will output
-        primary packet to out\_dev, else it will notify COLO-framework to do
-        checkpoint and send primary packet to out\_dev. In order to
-        improve efficiency, we need to put the task of comparison in
-        another iothread. If it has the vnet\_hdr\_support flag,
-        colo compare will send/recv packet with vnet\_hdr\_len.
-        The compare\_timeout=@var{ms} determines the maximum time of the
-        colo-compare hold the packet. The expired\_scan\_cycle=@var{ms}
-        is to set the period of scanning expired primary node network packets.
-        The max\_queue\_size=@var{size} is to set the max compare queue
-        size depend on user environment.
-        If user want to use Xen COLO, need to add the notify\_dev to
-        notify Xen colo-frame to do checkpoint.
+    ``-object colo-compare,id=<id>,primary_in=<chardevid>,secondary_in=<chardevid>,outdev=<chardevid>,iothread=<id>[,vnet_hdr_support][,notify_dev=<id>][,compare_timeout=<time_ms>][,expired_scan_cycle=<time_ms>][,max_queue_size=<maxsize>]``
+        Colo-compare gets packets from the chardev backends specified by
+        ``primary_in`` and ``secondary_in``, and compares whether the payloads
+        of the primary packet and the secondary packet are the same.
+        If they match, it will output the primary packet to the chardev
+        backend specified by ``outdev``; otherwise it will notify COLO-framework
+        to do a checkpoint and send the primary packet to ``outdev``.
+
+        In order to improve efficiency, we need to put the task of comparison in
+        another iothread; the ``iothread`` option specifies that iothread object
+        (which your commandline should create).
+
+        The ``vnet_hdr_support`` flag tells
+        colo compare to pass the vnet header length when it sends and receives packets.
+
+        The ``compare_timeout`` option sets the maximum time that
+        colo-compare will hold the packet for, in ms.
+
+        The ``expired_scan_cycle`` option sets the period of scanning expired
+        primary node network packets, in ms.
+
+        The ``max_queue_size`` option sets the max compare queue size.
+
+        If you want to use Xen COLO, you need to specify ``notify_dev`` to
+        tell colo-compare how to notify Xen colo-frame to do a checkpoint.
 
         COLO-compare must be used with the help of filter-mirror,
         filter-redirector and filter-rewriter.
-- 
2.47.3


