Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13688C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWekD-00006D-Mc; Tue, 01 Jul 2025 13:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWekA-00005n-9b
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWek7-0005Dw-QW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751390762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WxcHr28t5jXpHEtEJ4zOymFtqgR4RQWN8A7dLIEWgfI=;
 b=gyZcU0sX8xGzkW66/rvK/d5Lhk4PIqFVxyW9jE5UIqz23M4gQ62oSCU+vGzhnANyOzraCR
 FL9oZueXevDM/EeJDfHEvOAOBAC21NgheHJFTRFrIV6T6Cv3Ckl3GTctvgkQjGnN3iTaZ7
 wJB979sPsZODm6se+r4u095YnHPfupQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-Q9MO7mRvMTOaJbWxHGSGCg-1; Tue, 01 Jul 2025 13:26:01 -0400
X-MC-Unique: Q9MO7mRvMTOaJbWxHGSGCg-1
X-Mimecast-MFC-AGG-ID: Q9MO7mRvMTOaJbWxHGSGCg_1751390760
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2144586f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751390760; x=1751995560;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxcHr28t5jXpHEtEJ4zOymFtqgR4RQWN8A7dLIEWgfI=;
 b=Yd0gSVpZ7klnYG/F34U3lgIllEtJvmTgk4MkBLvJLI8+/U1ik08Pp5D6vrVfObTMIG
 ulHouepqUPlgNvlr0Aazwf1tnTxUPMOGhMg8Ris80EMBu4126EMLaRtvRSrRN0cpcacF
 RfsLsbjz4mveaoRLnKgVvNmtO+8xU35vBVWKcfo9ae6ensRDkjUo/ZbpVqU13sM9ctDX
 4uAnFnyjR+ScWbuSlsskTCey5vfszuegHoPVQorxkSzlkmVs9JLnVUXj+ZFMknDKya/I
 9YXdMF6wN5ntt9fIY3Ev4MjUHhx20/gcg+mQbBFvWq1ykRI/XM8xeAPAQzuHcBqB+1qs
 EtQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSvdhUwAzFTCDuJsmKqZBNmUiqIyXmAopVQTYMSfAVdwn7T/dRVDuFamc2ktOlkbPAiyqqzYJ7dGI@nongnu.org
X-Gm-Message-State: AOJu0Yy5VcZg0GIaGq4iMfwxcKrjE0Sr/+mdv4ohJiRCUMWubkeIzWe1
 slpABzsfPfCFm5Nmug9VMQf3NLEywoQ2xxWZKCazTqVrMRvpCJ3h38+GIph11bH0uKia2khAS0J
 hRkGlkv8zAU9hInyQxuti+uako6kiBrCNTLNdwwK891/UioSrZnWO14Sz
X-Gm-Gg: ASbGncu0nzEhwtO1LVJ9/jGG7SmAwm+L9SBGFn6KhlRHpk8POyrZoTfUxd45qhSR5wT
 3eYX+iEyxvT+kGBiuxvmckKQ9VsSHF5cB8tr9b13vkDrqlHKSizh4vL7lltcxK+3ZCWt1XEzUeM
 TdJblkcKDBBf46XkeMsh5AS4SPMev4gbKg65patrd+RlLprO4onb9oules5HC6rM7rWhPe35A2a
 H6DMZhViRrGn0CgZD6+JJBmfMBg4mzgSUUI8Qe3rzSoScyt6gTp7nEa2By38fkxCtwqv23PN4vq
 zgxXNNlTRpdru045HhVlZbWVHZ4Rcw1AzuafHFmWfixYEPvTqt8JVwTG+gndOg==
X-Received: by 2002:a05:6000:2a85:b0:3a5:2848:2445 with SMTP id
 ffacd0b85a97d-3a8f482bfebmr12267848f8f.16.1751390760071; 
 Tue, 01 Jul 2025 10:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6RSFP8Q6K2E0RNXqHd4iin/PR30OxJt8Y5BW9QmnohZkAfMOT37xOMdCRJMOoNz99teMn4g==
X-Received: by 2002:a05:6000:2a85:b0:3a5:2848:2445 with SMTP id
 ffacd0b85a97d-3a8f482bfebmr12267836f8f.16.1751390759605; 
 Tue, 01 Jul 2025 10:25:59 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-041.pools.arcor-ip.net.
 [47.64.114.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ad2sm13631500f8f.48.2025.07.01.10.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 10:25:59 -0700 (PDT)
Message-ID: <f74b1242-b97c-4b09-a663-9c6b96b23968@redhat.com>
Date: Tue, 1 Jul 2025 19:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] MAINTAINERS: fix VMware filename typo (vwm -> vmw)
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.04@sean.taipei>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250616.qemu.relocated.04@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/06/2025 17.50, Sean Wei wrote:
> The entry for the VMware PVSCSI spec uses "vwm" instead of "vmw",
> which does not match any file in the tree.
> 
> Correct the path so scripts/get_maintainer.pl can match the file.
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7428217361..ad82fa4d9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2539,7 +2539,7 @@ F: pc-bios/efi-vmxnet3.rom
>   F: pc-bios/vgabios-vmware.bin
>   F: roms/config.vga-vmware
>   F: tests/qtest/vmxnet3-test.c
> -F: docs/specs/vwm_pvscsi-spec.rst
> +F: docs/specs/vmw_pvscsi-spec.rst

Reviewed-by: Thomas Huth <thuth@redhat.com>


