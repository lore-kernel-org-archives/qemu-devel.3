Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A83CD37AB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 18:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slY1t-0002gS-0n; Tue, 03 Sep 2024 14:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dvdugo333@gmail.com>)
 id 1slY1r-0002fo-Oe
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 14:13:23 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dvdugo333@gmail.com>)
 id 1slY1p-0001QW-6l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 14:13:22 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a9786c5ec2so90823785a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725387200; x=1725992000; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yt2RE0KoR9WoYOg4+2y9BDmcx9FHxOZBd852+GrqUH0=;
 b=QeP3uU5gN0OWaKEbKGT/6n6WHPbtAd6nBrSyLJz9JsI3P4CZKl3gk2Rnt3uEcNtAr/
 aylkyjEA0PmfxpgBcgjZ7e+eMxP2VwQ4oO9GO5skPV1y97c8+qKu2fwMbBP9G7c0I5QI
 +ejRYNlldzToP+kT+BK4uExqqW6B4uOlQPQO/Tg759+I/fzHXRoNwy2CVDQ9ZAYrI6we
 JBtNU4cPdR92zVPUu0MwwGk/vsegqsDg6GVemko5F4MRbvgNzFVRW28xN4r3t4euJZ84
 Rmad53BqpYZRFuCluRgVaEJieZNtzmiLrR8wBPXiYdkZtwTLoc3tLEmirZHw2sDyCgfJ
 UWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725387200; x=1725992000;
 h=content-transfer-encoding:subject:from:content-language:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yt2RE0KoR9WoYOg4+2y9BDmcx9FHxOZBd852+GrqUH0=;
 b=Qa0r3/LA2KM/+ur6ChxeOIFtOa0fO5sN4UnGJyToqEEbCZ0hHoT5GV99hm4bDf+kN9
 KuFdaAQSUGTROsXITaAlSS58B3gEkudHOFUe/KBigh1IMQqwKUNdmBexLDSdnIlXLSVA
 ysb1LDKgJFk9o8BhPbnfgkSfOLMf95W4/gh8gXPoFvl4gDoAstoMyRrL8HFcDqcyRiwj
 Nx5klPvAWzRg0OZQtGhlGAkDUguEwRAyGV15JRT1IKgjceZMNrMEVIckBglijupkiBPJ
 d2r5bIPmHrDUWQRZQG+FlapDc6TOh9EKHNDozPdBBAjQASCOLVJ7nEt+HSVpBp/FmBwf
 zU7g==
X-Gm-Message-State: AOJu0YxPHDON7SXsG3ewmXxwaN4XmWqZO7jOHZCmiX9Xfevqw7jsVHS5
 lxqFfpuunpRJPMDHrvGGKPAtfB7ICK93SX9gp2rlah5j74lMn9rdHi/lGA==
X-Google-Smtp-Source: AGHT+IF0zV2CT1qbU5LyWgBnNqHuBFJ7l0VxegPt9UwxzotKlD6tqK2bA/yeZYoT4puTOq7oePpdhw==
X-Received: by 2002:a05:620a:481:b0:7a9:868e:f2b7 with SMTP id
 af79cd13be357-7a9868ef2e5mr27896985a.58.1725387199528; 
 Tue, 03 Sep 2024 11:13:19 -0700 (PDT)
Received: from [192.168.64.4] (pool-100-37-231-152.nycmny.fios.verizon.net.
 [100.37.231.152]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806bf71aesm549233385a.20.2024.09.03.11.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 11:13:19 -0700 (PDT)
Message-ID: <d5f6c856-169d-4dcd-acd3-d42d886df17f@gmail.com>
Date: Tue, 3 Sep 2024 14:13:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: en-US
From: DUO Labs <dvdugo333@gmail.com>
Subject: [Question] [Block] Is there a way to control the read caching of a
 block device?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=dvdugo333@gmail.com; helo=mail-qk1-x731.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I know that the `cache` parameter for `-drive` controls the caching behavior when writing from the guest to the host, but is there a way to control the reading behavior host->guest? Currently, on HEAD, if I open a file on both the guest and host, and write some data to the drive on the (macOS) host, the time until it shows up in the (Linux) guest is inconsistent (more specifically, it seems that the data won't show up in the guest unless I close the file and reopen it --- by contrast, if I write to the drive on the guest, it shows up nearly instantaneously on the host).

