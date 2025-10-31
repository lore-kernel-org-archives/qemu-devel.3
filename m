Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96181CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnkf-0002Ea-1L; Fri, 31 Oct 2025 07:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnkZ-00028u-JR
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnkQ-0006Yz-R4
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wka6/4ypPSZaKBUR8NW+l1dG+F0tcDS/RKul62uDrwI=;
 b=U8tRObUUbnsDjgbeGT2rubADBspuzA/rU5ZlykqP27PbI6iyaBWG60YKcG2mwopKbowMxj
 qyCSdQ9rkpFa/y6rhre6GjagNs9viRRfbNoLp+g/7cVlz4HOKwHAHJD4BMx5y2nJg3lJOx
 ZbgR1Dde07q0J7wYkpKaz0Jbi+sC8ZA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-XDLnBDMXPbW21mBBoItzrQ-1; Fri, 31 Oct 2025 07:56:43 -0400
X-MC-Unique: XDLnBDMXPbW21mBBoItzrQ-1
X-Mimecast-MFC-AGG-ID: XDLnBDMXPbW21mBBoItzrQ_1761911802
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b6d40007ea1so152138266b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911802; x=1762516602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wka6/4ypPSZaKBUR8NW+l1dG+F0tcDS/RKul62uDrwI=;
 b=rIctlGX4KzL/AHijFWwMnztMiYPemxvC3Jkvh5MrOD45fam6DAFeaG2L6YkBRcuX43
 5qZGDQGqmKoKWhBWmPUl18lkRpFHMdX/vjxx8RyVnCwOxtMSfCk0TfnSelDppM9DysRQ
 7KRKe1pUaiXpWff03tbblcgZWAFogQSBOrJh4H/iHNoKOapzR0pSsFL774avTfly2U4C
 78fAoRaDlnFzjI2oEyfeaaGV7N5xQHagzbg3N0mbaBDTmkequb2JbF5zkI0V7zIC6wJz
 VLUSim3nwRZTSjV9JotMNPIEJjRSEEqdPSYxqb2wir0F3J93plzsjPcLY+U0vRaErOLe
 TGBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX/FfiQLP/XBoAH85ux2otHd/XVISZE66Aq4su20f8onBOrHviUnyVIVaWq/J639QP+Hu/6wEXdUAY@nongnu.org
X-Gm-Message-State: AOJu0Yw4YeDey4EbA2XqE7f5NWgyV1i1ZOHT1FMshoxe7a3/eIC8DVuX
 E3aAHv7mCCOAN2d2Hdx3fUYCzULMXTnv3RVOrysevIcrXEkEuYwSVrDpgh/w+7Iq4kiam7Q2RQl
 4+pWGU0STA2HFJ67hF6360oCkwJ7sf731QsbT+kultz6uRBAe9USfGait
X-Gm-Gg: ASbGncsVPxGthGxvAVcewLOF/nfccbXXToQm7G5CMixtpNyHEJ0MCR+6ZrUa230CZF5
 S3Z66YUY4IZsEOI5cH3yB2eTvnDAbI/ImJ7WTzwR2M0xwZ37K4lBf6MYz57+//VdjzJsH42BBPl
 Oa9aYvIMzVy+ET9l3c6xrSauatU9bS0MXqFQNdV9tzgNI0TSQ0n7HeegenjMdOLrY8O762HYLcO
 7KrQz2w07vUcDjLbx6b9c8nPQPP6XoLoB1B5AmdUs1vsthF6vuPQOCwZzBTq4w9briTHVZVkA49
 6LL5mm0xrrrY10x7jphEjhX4x8CccLUc7zOBhD0upXKDrNEhmRpOba2mKquZpb9SgS0H7S0CptU
 YUhI5yTaflegN72Vjx6A7MZvj+T0TWZoVvpzLnqn3s7H9iEYTzEIM/kZhiv2OQlybtBsj6LyIG0
 nSL1G2z6N6MUQM9FpHvFUmBWmBP5AY
X-Received: by 2002:a17:907:7fa0:b0:b5d:7a22:ae41 with SMTP id
 a640c23a62f3a-b70701a8902mr295952766b.24.1761911801860; 
 Fri, 31 Oct 2025 04:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwRNtWJiJ91H4u+OH4bo4a2LJZwHbYcS3olw5OdJxtiythuSudGnPfhITcMEzEeMpitnR08g==
X-Received: by 2002:a17:907:7fa0:b0:b5d:7a22:ae41 with SMTP id
 a640c23a62f3a-b70701a8902mr295949666b.24.1761911801400; 
 Fri, 31 Oct 2025 04:56:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b438b05sm1387781a12.27.2025.10.31.04.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:56:40 -0700 (PDT)
Message-ID: <950e06da-1af6-4694-8623-8d6eabd791d9@redhat.com>
Date: Fri, 31 Oct 2025 12:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/21] block/export: Add multi-threading interface
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-17-hreitz@redhat.com> <aPjUv2YHrw_Hac0o@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aPjUv2YHrw_Hac0o@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22.10.25 14:57, Kevin Wolf wrote:
> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>> Make BlockExportType.iothread an alternate between a single-thread
>> variant 'str' and a multi-threading variant '[str]'.
>>
>> In contrast to the single-thread setting, the multi-threading setting
>> will not change the BDS's context (and so is incompatible with the
>> fixed-iothread setting), but instead just pass a list to the export
>> driver, with which it can do whatever it wants.
>>
>> Currently no export driver supports multi-threading, so they all return
>> an error when receiving such a list.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> diff --git a/include/block/export.h b/include/block/export.h
>> index 4bd9531d4d..ca45da928c 100644
>> --- a/include/block/export.h
>> +++ b/include/block/export.h
>> @@ -32,8 +32,16 @@ typedef struct BlockExportDriver {
>>       /* True if the export type supports running on an inactive node */
>>       bool supports_inactive;
>>   
>> -    /* Creates and starts a new block export */
>> -    int (*create)(BlockExport *, BlockExportOptions *, Error **);
>> +    /*
>> +     * Creates and starts a new block export.
>> +     *
>> +     * If the user passed a set of I/O threads for multi-threading, @multithread
>> +     * is a list of the @multithread_count corresponding contexts (freed by the
>> +     * caller).  Note that @exp->ctx has no relation to that list.
> Maybe worth stating that it's NULL in the single threaded case?

I think that’s implicit, but absolutely no harm in being explicit about it.

>> +     */
>> +    int (*create)(BlockExport *exp, BlockExportOptions *opts,
>> +                  AioContext *const *multithread, size_t multithread_count,
>> +                  Error **errp);
>>   
>>       /*
>>        * Frees a removed block export. This function is only called after all
>> diff --git a/block/export/export.c b/block/export/export.c
>> index f3bbf11070..b733f269f3 100644
>> --- a/block/export/export.c
>> +++ b/block/export/export.c
>> @@ -76,16 +76,26 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>>   {
>>       bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
>>       bool allow_inactive = export->has_allow_inactive && export->allow_inactive;
>> +    bool multithread = export->iothread &&
>> +        export->iothread->type == QTYPE_QLIST;
>>       const BlockExportDriver *drv;
>>       BlockExport *exp = NULL;
>>       BlockDriverState *bs;
>>       BlockBackend *blk = NULL;
>>       AioContext *ctx;
>> +    AioContext **multithread_ctxs = NULL;
> g_autofree?

Sure, why not.

Hanna


