Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937E7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwrG-0005TI-CG; Fri, 12 Jun 2026 04:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwrC-0005Sy-LH
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwrB-0000jM-8h
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 04:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781251392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cDnqMiJ8sHHyBuq3SMJ6rvVjG/BmlNmgHVGwf46DOqE=;
 b=Dfl4JrxmYCWUXv0HLvs1is3dypc0IcyOi+vt0RnyiAJrOviwZKydViNeusPcw3DPEUv6PC
 f/9/aBgxtwdmLCeNPXGUGyHWv9qiZvxg/7yEMLmIAkgNzOeFDW/kSBHjWhdWPqxFJIP91p
 /dxnAt8wmSA+1ioajnCwjdGgvQ87/Ys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-YIhX_lpCNNu2lzhHLsr_kg-1; Fri, 12 Jun 2026 04:03:11 -0400
X-MC-Unique: YIhX_lpCNNu2lzhHLsr_kg-1
X-Mimecast-MFC-AGG-ID: YIhX_lpCNNu2lzhHLsr_kg_1781251390
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eec2badc4so334793f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781251390; x=1781856190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cDnqMiJ8sHHyBuq3SMJ6rvVjG/BmlNmgHVGwf46DOqE=;
 b=I3ZqL1QuWgncxUaSQnFhOMqYJgFJK2s6EqedZnXCR3mKEcSh+VMhuLVOVs593p6J0O
 e2xNAfnGQ+zDtqgIOkY7J7m6xoiDenxF8IPEEr2ALAcnJJKygAWAgNTGJbq0J3XOI1Ww
 UAR0TeqHrFfzaMjqyHlg/0Ant39LbisgSw/WkgwlYc8QZjsmcRthZYXSex/PLtKcRoFd
 dHlauBX7y0kbsmjDRTm0wagaKSJDPYyLRuh9QamJdTqquyVwRQWMev68LDFyRAdIdsx7
 GRdABZsY9Htrx+eF/oo2N6E4tkRRxfk9sV/+lpuIRKBMWwISfFtlSdH+HJvrwDoefD/D
 CBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781251390; x=1781856190;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDnqMiJ8sHHyBuq3SMJ6rvVjG/BmlNmgHVGwf46DOqE=;
 b=dNQ2CCKEV/gsrmN85rPaZG5msy+yv5/SnPPcDCXYg+OL4/inR4j+jucyHo8L//122K
 +WZYIpxXzACB0Mf/ZJWnFfpwQujCqFjH8Xj1Avj0tODV/XpR2HrofIJus7BUQvLX3NX7
 E6m559Bd5UojS+2amFmRtMpCHuWvWKcIqGeF5Ut3MuUAwE6tWPrwlC8IiFqrf+Mtguox
 vVqlGzLbaA26/k2xXh0cw1GEz0FTYjxU9ia0Ovwh4cYqHOqtx0aQtuZ61Bx7tVRxX0ok
 sVREmaflw1XxuqK9+R6/fE5uIgMQ8n07fXDPj8Hw2+ZgpvAOMeKPHet4+rPO9RwLFW69
 ax7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Qui5cHpzUvLCLQntIaBBw1exlwgPFHzY3Ndi0eE1KaKjbVU1D9L4EYeXTSK25F4nihPvGFSqyhp9E@nongnu.org
X-Gm-Message-State: AOJu0Yy0ap/SYR0+z35oWenUZamGAVFZ5bfCX2aZ+5ywguegMUXAgEFf
 3Xd3+5W1gVPRHX3sNQh6qllGLMBW1u/UPZR9eIHvN7pdalWEYhLuKi3LxFAlU4BQtAtVZicgWIR
 apyTxsRK8XBSRKwWvbMnqP98bjo0P1e3WEbM+A8NtQTs0SrpBGiP+vHjZ
X-Gm-Gg: Acq92OEYGt+Py51DTSv+b7BuAMlFYHCZ7xL5L0vLEPgZg72uKZfnQTKVijDjEmV5M3z
 yO65wfNPotDJ8rlFvbFSLZUwMxHR/UYvsVYeE+gULRlQD2qDAtTVE08KKzbINV8ya+s5I71+Inb
 Veyemx5QkX10U5H/jE9+86bvF4gPAfcXdXrm4hYc1gOD+eswfVWLjZcPLipqiqvT/kaUFmlBllc
 7B2WvfMKG8M+f9Llt8H6p0sllr5sWLSwdwBHPEcLs18O32lOv5YU77EmuV4tkSfzaaWLNuIeTzr
 NSWC9ReJbSmaGB1iPfZVxBRA+D9YYE8WDOXBQHO5/rXpEb268MLoUMUsfQCoYjdMavB2oi7xzg8
 nzbVfX78OK5jFM+zZm9ldsV73cgyq5jmE7gh+aLBvuHfBCE5XVRzPu94TNOvs
X-Received: by 2002:a05:6000:290a:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-4606dba4105mr2363901f8f.20.1781251389669; 
 Fri, 12 Jun 2026 01:03:09 -0700 (PDT)
X-Received: by 2002:a05:6000:290a:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-4606dba4105mr2363821f8f.20.1781251389087; 
 Fri, 12 Jun 2026 01:03:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm3425377f8f.37.2026.06.12.01.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 01:03:08 -0700 (PDT)
Message-ID: <dc06f80d-4853-4d33-83a7-3f3b79180f5c@redhat.com>
Date: Fri, 12 Jun 2026 10:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core/machine: Add new compat for vfio-pci ats
 property
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-4-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260612014322.2918836-4-nathanc@nvidia.com>
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

On 6/12/26 03:43, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
> 
> Introduce a new compat for the changed default for vfio-pci device ATS
> property, from "on" to "auto".
> 
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4d8b15d99e..c0cdf7c9da 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>       { "chardev-vc", "encoding", "cp437" },
>       { "tpm-crb", "cap-chunk", "off" },
>       { "tpm-crb", "x-allow-chunk-migration", "off" },
> +    { "vfio-pci", "ats", "on" },
>   };
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


