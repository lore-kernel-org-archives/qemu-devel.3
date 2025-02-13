Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF71C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 10:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiWUV-0002UG-A9; Thu, 13 Feb 2025 05:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiWUU-0002Tr-4i
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:30:42 -0500
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=1325cea77=graf@amazon.de>)
 id 1tiWUS-0002Rr-7P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1739442640; x=1770978640;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eTuz5eu7O4IP+PH5YDbiBqcEfIAn/vn5PLPEHQAXhGU=;
 b=ZMI33WNAwmDe+0K2em314UdmGkOX2f1lp7Q65ElSVgMn04ygp6/TZ9Ln
 d6jZLXZG+rWoH7EmfLrLjwy5EEKp3C8LiUfeXA2NuhFIfVhnR4Ip9Jich
 GxwD5Mglhc0iQhVHH4nvyADIM92yjZW4Z72Xwa2vfnl9+GdWf8Mz2T49a g=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; d="scan'208";a="169327045"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:30:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:53410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with
 esmtp (Farcaster)
 id 05f1e083-6d72-4447-ba43-36500331b2db; Thu, 13 Feb 2025 10:30:36 +0000 (UTC)
X-Farcaster-Flow-ID: 05f1e083-6d72-4447-ba43-36500331b2db
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 10:30:36 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Thu, 13 Feb 2025
 10:30:34 +0000
Message-ID: <6e184a9b-32f2-403b-b499-5d3b618e0bd8@amazon.com>
Date: Thu, 13 Feb 2025 11:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu Nitro Enclave] NSM virtio attestation response is always of
 size 0x3000
To: Vikrant Garg <vikrant1garg@gmail.com>, <qemu-devel@nongnu.org>
CC: Dorjoy Chowdhury <dorjoychy111@gmail.com>
References: <CAKXOwk1_zPNBaQZyiHb8A5D+3euZuvjW__Cqi3_PKgad95rDKg@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAKXOwk1_zPNBaQZyiHb8A5D+3euZuvjW__Cqi3_PKgad95rDKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Received-SPF: pass client-ip=99.78.197.219;
 envelope-from=prvs=1325cea77=graf@amazon.de; helo=smtp-fw-80008.amazon.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Vikrant,

On 13.02.25 11:01, Vikrant Garg wrote:

> Hello All,
>
> I am using the QEMU for emulating nitro enclave images. In my enclave 
> image, I have an attestation service implemented in Rust. This 
> application fetches attestations using IOCTL command. I have noticed 
> that response from the nsm virtio device is always of length 0x3000 
> (i.e. maximum NSM response size). Instead, it should be the actual 
> size of response bytes. Same case is also happening with the 
> attestation service implemented in python. On the other hand, the same 
> Rust attestation service is working with AWS nitro enclaves. It looks 
> like an NSM emulation issue.
>
> I would like to confirm if this is the expected behaviour and need 
> help on further debugging.


Thanks a lot for the report! Does this happen with all commands or only 
the Attest command? The NSM emulation code attempts to trim the response 
size to the actual payload, but there may well be a bug in that logic.

I do have a hunch on what the problem may be. Can you please quickly try 
the patch below?


Thanks!

Alex


index 098e1aeac6..b22aa74e34 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1596,7 +1596,7 @@ static void handle_input(VirtIODevice *vdev, 
VirtQueue *vq)
      g_free(req.iov_base);
      g_free(res.iov_base);
      virtqueue_push(vq, out_elem, 0);
-    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
+    virtqueue_push(vq, in_elem, sz);
      virtio_notify(vdev, vq);
      return;


