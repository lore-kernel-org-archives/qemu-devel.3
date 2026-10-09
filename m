Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8192CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9kn-0005Cp-8z; Fri, 09 Oct 2026 08:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xF9kj-0005Cg-SZ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xF9ki-0006Hp-I6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791549067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fDUaV5SdK24VkxGZq7E4dytrjgorIsXpmjzzH9S+bzCATkuGHIVwCFCLXj5gPTR7he7EAR
 UhXHUthonW+KKtVyy+G6C9wiSX7xKBem22HxFWusgSjfVxAIfjIfAVR4V9G4Ww53pdmXmX
 +PVk2R7tnNd5zPbjBaB+dvK4mmUW2NA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-yrRnUtVbM-GnPkvZoovAMA-1; Fri, 9 Oct 2026 12:31:06 +0000
X-MC-Unique: yrRnUtVbM-GnPkvZoovAMA-1
X-Mimecast-MFC-AGG-ID: yrRnUtVbM-GnPkvZoovAMA_1791549065
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a17e77c5b1so24644095e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791549065; x=1792153865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=lyfCIXJ2L8HEVdDc2h8V87YmvuZYR0xx1wQLFgSmoSW44+M5TLUC7/Umzyis7vTEZt
 UDyFZduoQIf+5L6PbKWCjVvivQKF5uk/YI8cK67HvbJIZ93/mhzSrU5BP4YPCeLt2uxl
 u4qzkBcMeJB3t4PqzaaNyWacH0Mtzu7EyMCR6lySCxQ2tQ5Q/BMJQ1cf5N5ffcbrFDv9
 AhmWjfW+CDkiMp2/xh+Xlb1EKxC3AsVXHqlVo9UWpGk1Zb8FhhdAh00D2F0SJfqVCl2+
 az5b3TPfJT8HxaTbE9LSedS8W9u4Hxj0K+2UjISOlx/l9Sm3eJkpkVABFFrSM/8b3Yjy
 JO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791549065; x=1792153865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=z9VrRD72Imv+wDte3Hq8BZQUaqTNee3QTrV51IAzsHVNftoG/BxPXAMmHfQKT9lRud
 R75Zk55G2T/YzrDEXjVYHneiyKDrxOscOdwp7sZSIFD0c1xLcmudVU1AQK7YB7aCTYjC
 8KRcQOCijPpppImMU2kKYNTHhqtjlfUgPC7PED/Jxdto/Wuro8OQwZ//3rd1ERl64Exb
 7SEzewFysN3vuJon30kWAq/qAAxTVBu29tHS0ybPcv1mmEOEEh3HnD6elHVQBpBDZopz
 mQ1BffmxIm7lm5uMNpuKAz43lseywi8J2GUDI9QyIGHRPxnQAb1Kk19CjV0snl5XkUKV
 E+2g==
X-Gm-Message-State: AFuF++nM8U9nf+jaF+SAiM9Ajq0zS+i2b13telzdpATl00rOaFoIWoem
 xIOiSI2oIe25IPb4jcGooArA00GsTj3aJtEMSUYGPODX720+J2ys5BlFxsiIeJBULtsKIlFbViy
 gbhDDyw7razcqFE7eo9JpO5HZ6gA4V1dpPJ6FNKLV/01U9BYwUq19UR7c
X-Gm-Gg: AYBFou2aojwDouuLapwxah43xoFUuaOjnamy95PNvNEYWw58N2v1U8otv499WFR9cKt
 SFJihA7vgY7zWJyVGIoRixJyME5RTV4FDOo2xGhHewmxere2YjOM+tzNWp3svfq3WXyq8U7UPru
 ZuIOT+8cbD7sg0PilgTViGultPS6MATyHdxeneeeuSd9W2EnfduwViHKwQoltuEwJZTseiiP69b
 dLF2APH09DBp3WB2Ga/QyTlUMWO0x6owBqmBWeda92nQ3Lft0Ah5kYYexILZlu/C331buOPahMb
 zYHbV5qysVNY8supJpflOuk5gN79CT/EFL4/QjnTlhgGpvxitgHyK2eLmejLl7XyAi56LqC7KWd
 akfVxp7G/miMhbdjSfIoeBGAxJnRUhmjVYUvmnJXn2x5Mw8R78oWav00cTV2K94sbMoN+P70i8e
 KF6uMr
X-Received: by 2002:a05:600c:8b64:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a18e498851mr34836895e9.19.1791549065063; 
 Fri, 09 Oct 2026 05:31:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b64:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a18e498851mr34836125e9.19.1791549064699; 
 Fri, 09 Oct 2026 05:31:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea1fefsm65256755e9.11.2026.10.09.05.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 05:31:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Artemii Mashanov <ralerrdirsardx@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH] target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
Date: Fri,  9 Oct 2026 14:30:55 +0200
Message-ID: <20261009123055.351478-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826171655.117679-1-ralerrdirsardx@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Queued, thanks.

Paolo


