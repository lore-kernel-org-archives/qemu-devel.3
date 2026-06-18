Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE86BCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAAs-0008CS-0a; Thu, 18 Jun 2026 06:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1waAAq-0008BG-Dd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1waAAo-0001Kp-SO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781779237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YnzIDJdHtua32EUmXdeq26QFA31F1dpBh/+06MnVsn4=;
 b=K1oj1wAZBSWD+s1WGnS+zZJ5exK6B9RyWT4LGH3W3sh03rrBrOEj0QcuGByCAVbdf6SavZ
 V5wXyxUrpmh7PRP6s0a6yxNIcg3FZ5aUDxFTq23fUdxRbbvHnSIGpX/7vBiaPOW7DR8LUF
 AwJ6asJylECZB6ontN/dmAxp1Ar5R1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-GMPTTo2bP02FwxAOFFklyw-1; Thu, 18 Jun 2026 06:40:35 -0400
X-MC-Unique: GMPTTo2bP02FwxAOFFklyw-1
X-Mimecast-MFC-AGG-ID: GMPTTo2bP02FwxAOFFklyw_1781779235
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46315372c3eso760612f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781779234; x=1782384034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YnzIDJdHtua32EUmXdeq26QFA31F1dpBh/+06MnVsn4=;
 b=Zm7Ia3wRusLRb8uzlo+riMS+hA2JkhvhQnvlsV3KWUZWHwHNYWH7g+YmHyuDEg9wlh
 s6oSLlkryc/yazMoGN3Qo5r1rBjqieYt0fkFR868Lunfi0uqkl59GNrTlZ0FCUF39AbI
 ftwjc3x1DVnPKuLW6P1mlmuHO5GDbE5Zrw1GJkIWelXx/XYknzA5my854+TIXicPAK0X
 vhJlFLY8LqT5z03dB0C6y0ftdhLAuTb1NCWgrTGlKOyMzv5/6Xt5rMr3OiVJPqt1Y0/F
 fQiCOAFTrT7RkYtFt4/+Hnmsa1PDl+n2wsvWacLr4TpjeDtIkGoR0YmlfkIK7J8HHPRD
 wmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779234; x=1782384034;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnzIDJdHtua32EUmXdeq26QFA31F1dpBh/+06MnVsn4=;
 b=GewGY7SVxUtnwLro3wy0jZLJgVpC89n9wXxF7fj/UME36gUzJ7axQ6B6t6rM4JydZ7
 Ap2v3JoVim5VpD2RjmoHI6kDDX/mZ/wL/DdzysoxlAS/uwNgtmMiAJZadSHA0+0UfPl5
 QprDYByA6dj2xlCwmz8dom6qg875yM+AuMw1ZYAHrwQ1AgyJlr2g8LvFrnfAgKEteyaS
 R820REmC/EJwRQFN/xe8TmSZc7+LEkpnnOr4vVHw2nmwV3rDu9eubBNZBu1ySaSmE+U1
 1eHIrd0lBcczkwR20LHlfizxb22XNapmsEddUf/HI6JY+N3Wpp6W+ync9ana0Ouy1lxw
 AAMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ81E5Z25Vg5f1iFSgZWJS6WCU1H3WoU0DbcK/AJJoi1SmoCzKx3AWbU6DcbtxHS/O2LTCm6Kw0CEq+r@nongnu.org
X-Gm-Message-State: AOJu0YxIxYmqJIvt94hyAbexGDHhwMMCgT4lVA/qRcupMfibUZtIHL/l
 /AV819BsBB6dv2kv3wsl2VbaxAIx+OMMz3YCQt63/D7rq6Axm/ME+ErCcQ6YAFt7dDjL3DhoaZv
 UDe/22a6GaGNDL+xzmkXWTU+vjDwOMOaZXSJIc++oHi8t/D3KAhLQMrjqnyiCBs7w
X-Gm-Gg: AfdE7cl1AnRi6pP/L0rWAXjSpemHvgefNTKVQ904TBnF7dOpAUSXyncI1xpao33Qbo8
 fY11ShqGXKTiBt1ydduUnnI0RQYCX3tIqn9xlj5GPBWQ4I9CwRMb0DCr2dXpVFG2H+d+7GxF1I9
 xLS8e2YIch0c8M5Pa5BiXKEqwMP/ZTn2qlAABI7V21LtYiTERvtzKKF3rfJzInrjGQn7c/fNwQU
 +E9KgBhalPQhBT0r7GV+3/jdmTE34szpxv16YeRl4HUcq0JR8ZoQr/vCznxtk4RzhmEzzjnCuKj
 CqfyCnE7B4leHkWQ5gMt0SoMOaBvXTULMuYrViYeE6tLsHSGgRUWy4nrAv08JXhESaaSedsnd5m
 rxutyhXYFZijySCF4LyO8H3Nko/Vfow9lqvdfDrax04m0WEX/ow==
X-Received: by 2002:adf:ee4f:0:b0:45e:f5bf:6c25 with SMTP id
 ffacd0b85a97d-462389d4195mr9710537f8f.32.1781779234495; 
 Thu, 18 Jun 2026 03:40:34 -0700 (PDT)
X-Received: by 2002:adf:ee4f:0:b0:45e:f5bf:6c25 with SMTP id
 ffacd0b85a97d-462389d4195mr9710496f8f.32.1781779233993; 
 Thu, 18 Jun 2026 03:40:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm63942380f8f.1.2026.06.18.03.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:40:33 -0700 (PDT)
Message-ID: <f758c052-393a-4c99-a53d-f63ae9d79744@redhat.com>
Date: Thu, 18 Jun 2026 12:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: K S Maan <kirandeepmaan45@gmail.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <9268e0d9-c62b-4b9e-9d7b-d15bb4ecbdde@gmail.com>
 <e4c5461f-3bc6-4796-a142-ac4a2ce7f719@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e4c5461f-3bc6-4796-a142-ac4a2ce7f719@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> 
> Shouldn't this series include a Resolves trailer for :
> 
>    https://gitlab.com/qemu-project/qemu/-/work_items/3093

It's in the last patch. All good.

Thanks,

C.
  


