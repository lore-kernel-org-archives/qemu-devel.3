Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8127AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNVo-0003Tm-76; Wed, 08 Jul 2026 04:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1whNVY-0003Ru-QA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1whNVX-0004d6-3z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGBCK2fEfMHhPSIVcMvRhfiIqE9ORXQzCYwE1b2TRdg=;
 b=ROvlaGzNovvg0ZDqEmSzqUGzKltstGQ6USbrJ/Qlb+wgmcfkvtZ3uXTeqPi1s/36A/8a1x
 pk7c6jHfGoYFU98WYbLluZTPU8xd9/h/l5gKXpnDJlpWcgFJ0rqZO18Dvv5Ig5cbqIDUTH
 Z/tfbddOoYKoGgXN85Hab6Xehvx0ZPA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103--irormFTO-6ocgXwHW-XcQ-1; Wed, 08 Jul 2026 04:19:48 -0400
X-MC-Unique: -irormFTO-6ocgXwHW-XcQ-1
X-Mimecast-MFC-AGG-ID: -irormFTO-6ocgXwHW-XcQ_1783498787
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so482804a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783498787; x=1784103587; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UGBCK2fEfMHhPSIVcMvRhfiIqE9ORXQzCYwE1b2TRdg=;
 b=Rm10weFkcJ3LEOYevP7lMmpbIToxAE94wAFWTTdAiw/zj6cRjT2q5OOI6CJVcLufvW
 R6uvP+xvqYAInJhigdZ7dAw54EMpFsrJI4ijjcfYnpondWxfFDMGY8Fj1ISpi/nB+snm
 73CtyhaGjssK6QCsZ+ibYWx0Q1GzLmSJ832cvOplqObEXit1QZhGPsj6y8QqbTsjZIP7
 PgwI8dw7SFRfb2+IElMIIkyQhAOkRitpRyVZRVdYpiCEiExREKqu2omyw3T8UOWoWW9M
 mNWuyNxIRDR/H/OmCoL5EmvvqUkmeWHdUeH6pITW2I1E3Os94yUctlSgkCFxsJK4ntzv
 CJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783498787; x=1784103587;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UGBCK2fEfMHhPSIVcMvRhfiIqE9ORXQzCYwE1b2TRdg=;
 b=nBhvzSelU+8fHmWsaHdSY0b9eUXQ+7GxXRTQrVHJbToXo8uHZz8TihqfF6rgoj3ZTc
 gt3YNefeUObKNup+F+5W0uK+mwKNDdaO3d1Ec/Kua/FYpzlBYNrhxIQefE4rEKVWwaeN
 WgFbZbFC4OBKhUjt0M2QbAOsRaKJxh37OCMJspAP4a3Kk58kLShpfKHAI4TqskezE7wa
 fU7ns7V6YTmvu7q7qMSdR6JDTW2LfGpdwQ+cvnYuRJPXzZXtoF+wTEpeJ4++Kb+VLcww
 fBOly3+XjPrKpfmj7jewG1kmqWZEQnoXcJBk1EB68vFo7ZejZb711y+9T0YPsS4BcEn2
 MBtg==
X-Gm-Message-State: AOJu0YygbMbvOGe2EdMuBx5RkicyznadmIvXSsFS3WqKJCfyxhSf/fet
 qvlx0XDs0tsAT0pHye2ro3qm5SEu9ssEUsxNrgtAAtnnpPp9VEZMvCW4Frns7V0p8lUUMYpqlpz
 G54/hXGvhegWaG/bVjXPOCNw7R6aDBC7s4EXksd6LWXUah2hMVUaBki9dddvlgQxBHHBG1AaLhc
 cnPCvQikU9pDoBiwhS1rNMc5dzGQe6BK4D/YJEPQ==
X-Gm-Gg: AfdE7cn258NQBiEHk7gLcbYc1jUdfGSUycUWc5g85hL/07NPCkxo4f0b29XIXfzHQTa
 AiCtcHiQ5hPc1Yrc+kFzH8pyF9mGG9WkauqFSjzrJjek/YOgivfGAQKd+i8ovBX3Nh/QAw39kDn
 rXzvUDcGhJk6TPU1s4EqG80i8BDT1K6BB3Y/8KIUF2Ua9Fa/vgq78C7Lfm01FakOOXtr3UfuGVk
 isZ8UkIJ4HEqukEFRHB1W7CYlz/kQPsJUKlmqulKAB7QP1q0LB6qAG0F3oZ8nOvVMbvDHA2zSID
 OsE/TrDjphfd7YTERNSPM+Mhs1RZ3HqsVwsSPGTBZumUfgN8w2Q5XnYPjZ6nNY+0xnuUpdT+qO0
 OgiUKClehhw==
X-Received: by 2002:a05:6a21:6110:b0:3bf:d1f9:b1d5 with SMTP id
 adf61e73a8af0-3c0bd19ef5bmr1728884637.60.1783498787254; 
 Wed, 08 Jul 2026 01:19:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:6110:b0:3bf:d1f9:b1d5 with SMTP id
 adf61e73a8af0-3c0bd19ef5bmr1728828637.60.1783498786671; 
 Wed, 08 Jul 2026 01:19:46 -0700 (PDT)
Received: from redhat.com ([2405:201:d019:c162:22c9:3093:86cf:366d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d87a2sm16162140c88.13.2026.07.08.01.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 01:19:46 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:49:39 +0530
From: Utkarsh Singh <utsingh@redhat.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, mlombard@redhat.com, jmeneghi@redhat.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2] hw/nvme: add user controlled 'vendor-id' and
 'device-id' properties
Message-ID: <ak4IGxZbO1xgdc8z@redhat.com>
References: <20260624134255.558888-1-utsingh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260624134255.558888-1-utsingh@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=utsingh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

Following up on my v2 patch adding vendor-id and device-id properties to QEMU's NVMe emulation.

I've cataloged the real-world NVMe quirks from the Linux kernel that this patch would help simulate. I have tested these quirks with this patch:

PCI-based Quirks (Vendor ID + Device ID):
   1)  Default Red Hat (0x1b36:0x0010) - BOGUS_NID
   2)  Intel QEMU (0x8086:0x5845) - IDENTIFY_CNS, DISABLE_WRITE_ZEROES, BOGUS_NID
   3)  Intel 750 (0x8086:0x0953) - STRIPE_SIZE, DEALLOCATE_ZEROES
   4)  Intel 600P (0x8086:0xf1a5) - NO_DEEPEST_PS, MEDIUM_PRIO_SQ, NO_TEMP_THRESH_CHANGE, DISABLE_WRITE_ZEROES
   5)  Sandisk SN530 (0x15b7:0x5008) - BROKEN_MSI
   6)  Sandisk SN550 (0x15b7:0x5009) - BROKEN_MSI, NO_DEEPEST_PS
   7)  Samsung PM1725 (0x144d:0xa821) - DELAY_BEFORE_CHK_RDY
   8)  Samsung PM1725a (0x144d:0xa822) - DELAY_BEFORE_CHK_RDY, DISABLE_WRITE_ZEROES, IGNORE_DEV_SUBNQN
   9)  Phison E12 (0x1987:0x5012) - BOGUS_NID
   10) Phison E19 (0x1987:0x5019) - DISABLE_WRITE_ZEROES
   11) Silicon Motion (0x126f:0x2262) - NO_DEEPEST_PS, BOGUS_NID

Core Quirks (Vendor ID + Model/Firmware):
   12) Toshiba (0x1179 + model) - NO_APST
   13) Samsung X5 (0x144d + model) - DELAY_BEFORE_CHK_RDY, NO_DEEPEST_PS, IGNORE_DEV_SUBNQN
   14) Kioxia (0x1e0f + model) - NO_APST
   15) LiteON (0x14a4 + firmware) - SIMPLE_SUSPEND

I'd appreciate any review on the patch.

Thanks,
Utkarsh


