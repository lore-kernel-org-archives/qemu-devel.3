Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA5CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLqM-0007M1-GZ; Tue, 16 Jun 2026 00:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZLqK-0007LQ-GD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZLqI-0002MX-M1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781585764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwZcKCqR8JDLXYMDOK12GRhm9ggAjDLD6MH2lffyvW8=;
 b=OTzHs8akknTDM9W/JspswVirrKCupcX/RFmi7Fwts6O+/v7KECsUDX8nBEdRvebrHm1bFZ
 sponVgs/zhvbnGrFZZK1BJD1OBrL1JyWD6BNspSCtK6YD3jST0ehJDsevJnyO0o9oI3Keq
 zto1rT86Qeo9jsSWLr+wuEljt2k0zYU=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-IKNBnV2PN6qdft63hVZtAQ-1; Tue, 16 Jun 2026 00:56:03 -0400
X-MC-Unique: IKNBnV2PN6qdft63hVZtAQ-1
X-Mimecast-MFC-AGG-ID: IKNBnV2PN6qdft63hVZtAQ_1781585762
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f23c55b2so5092843eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781585762; x=1782190562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KwZcKCqR8JDLXYMDOK12GRhm9ggAjDLD6MH2lffyvW8=;
 b=gR377DekiE7ruLqlNPp/gwP6KWwqcQ8qW93iFxAgVvxX2k5BB9jDPPIP/NqQLSzr5R
 NLamkevEZHhmDBssi6J+71zVCMUVUzqx3uBNYacnCK71iRCHcP/Mlbe87xeBybLV6x9/
 MqErAfCYTgBiK+sVqSD6XxBeYeMasm/InH/TJAo6+o/5BNdg9QRPNKtZCVd1xDbR7JJu
 diBPSq4y/3NJcdpo5vg9kkrePmRUkDXy5DhTwvslWdM8LH/tBJx9NJVV9f7S+6ItX8mK
 hNqid5HBRHQQlYgdyYPJDPTpgbBAfan9RE3UgJNXlU/20nakX24kxijf7nb6ut9MZO3x
 A14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781585762; x=1782190562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwZcKCqR8JDLXYMDOK12GRhm9ggAjDLD6MH2lffyvW8=;
 b=eDONjLMWlv35YopreRph1yAOth7LdW3y+WbWFUv9l4qYcerPUFDphYKA/cOv1xhiZl
 p4hs4O3KQsiWIePbEnqbBbnJhAtXQ01cp+YPyAwO/jR2dzBVtiAEssJWHa09zevDroh9
 s9ln3b0mGXJoimabTmYNl9QBo2i2O1XGZRkhlBS4CXecFEVLtO4q5Un2R4e41gB0HDKs
 9YgFHyC9cBnzNfVcR3ex5yusV0wUeZWBgAw7SEtmFq4yqH9foQwfoFFUspX/RPfVvB7i
 UxIYG4Wx0+tOGLvIZ1pvJHX8l7tFP4A0wxzzU3gFN9h+FUcrcqMTuqV8O97fSRpz9t9I
 smug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XWo0A2eZL4Vb6ixsUEC0yas9ayGmoC8QOkgdUyTrCxUG7H1CFCpMyGO2uFGlUa2QDKlFyLuUKfrD5@nongnu.org
X-Gm-Message-State: AOJu0Yx5nnn321mhiXLCSB1XW94irZ1BO9quw8r8pIK454frZ8l/Cgej
 Bx8DALFKtsp3MoQWKRGMxEIMqzDGTf5tGFz6VHQkIifp9Qh3N90EExCfHJJCTErng9kyzE5qjck
 sxB2T8uq4eW+s4dkwX9wUzOIB9YN1mjXPRd6MTVDIwzml8oNdrsY5PnQS
X-Gm-Gg: Acq92OGQpzIkrQnMxoq/9R0gozeuZI/jvOE5JFKnhtaiE7pIDG4GaduqIc4tjZjycXo
 eiVNohktPrSb2OemXZSIyyv+rYnUe2UD07RoNbszCUJfix/pSt3HMC83a/aD9y7xOsGnTOzJwsr
 odVdhoZQGWAif+MYlu/kU9berLzyMBYS7rjmuKKtmCPeENtTx/YP7tnrjep+4d1qwYOysz3TnMH
 LI++0saR/MDeFqTcgw4gKE60xnYoslkOrVV8gw2FQLN5JWfhazIWAW7QPtMyYwNXo3JqBjXT8gR
 IZrFzyU9IekkuNoDjCvL7E4NkAv4WndO9CDK7yopP6AAvvfhwUCRWO3KfmZpX8vHK5HHtUHni38
 b0x/+REgLD5iWFcFoPJiLuS2ufMMaHbtY4qqBsgrlkCocZ+lDGagv/oPt7OhI/tWF
X-Received: by 2002:a05:7300:7c12:b0:304:d32e:65e7 with SMTP id
 5a478bee46e88-30ba559df7fmr1211671eec.0.1781585762243; 
 Mon, 15 Jun 2026 21:56:02 -0700 (PDT)
X-Received: by 2002:a05:7300:7c12:b0:304:d32e:65e7 with SMTP id
 5a478bee46e88-30ba559df7fmr1211653eec.0.1781585761742; 
 Mon, 15 Jun 2026 21:56:01 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm18880655eec.8.2026.06.15.21.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 21:56:01 -0700 (PDT)
Message-ID: <3880910f-4465-46c5-a5e5-daa2f70821d1@redhat.com>
Date: Tue, 16 Jun 2026 14:55:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
 <20260615224658-mutt-send-email-mst@kernel.org>
 <0038f601-7647-4547-a67a-c6a17fae26ca@linaro.org>
 <20260616004924-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260616004924-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/16/26 2:49 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 15, 2026 at 09:48:00PM -0700, Richard Henderson wrote:
>> On 6/15/26 21:23, Michael S. Tsirkin wrote:
>>> B. Also on x86, I do not see why we should not use memcpy for large
>>> accesses if we can. Better perf.
>>
>> We have an example where memcpy writes to the same location 3 times.
>> This is not appropriate for any host.
>>
>>
>> r~
> 
> as in, same byte?  could you share the details pls?
> 

This issue happened on aarch64 only.

https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/

Thanks,
Gavin


