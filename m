Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432F7CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 14:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRW70-0006zV-SI; Mon, 25 May 2026 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wRW6z-0006zN-SG
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wRW6x-0005NC-Co
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779718613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p6PbnUhU95hpAtv9mfUJb6dg7Tc9KVwuspNrgFqyJw=;
 b=JhJAQzSJgCJFMfnGc21gyPLXrgraFpIKgOrUajXKacazUqFKG0TDsjiu1fD6+an41hIxqn
 8eTG4edfl1rMt8WrbLHlB+Dwelmnwbqyp5CrwlyXR6vRUrMlGs/lNG8WK5us4jj64riNMP
 vhtQNT32rJQcPJJZ5/p2zxOaPsSWUgk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250--3uZbDU4OXSWaiINxLsHRA-1; Mon, 25 May 2026 10:16:50 -0400
X-MC-Unique: -3uZbDU4OXSWaiINxLsHRA-1
X-Mimecast-MFC-AGG-ID: -3uZbDU4OXSWaiINxLsHRA_1779718610
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914b5249bc1so478881685a.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779718610; x=1780323410; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8p6PbnUhU95hpAtv9mfUJb6dg7Tc9KVwuspNrgFqyJw=;
 b=l3vg7wvxecA3YBrx8F8PC/Phhu4E7MNvc16bByvQmiI9ZxXUthQ8Z5ZexdDn6MFYtX
 gQ2M6kJWyjVpes8/M3+Cco/FPSqKOE3T5kfAxq4kOdU5fnUIBBVM0IEGCmnCPUBkFw/Y
 jl2lSV1/eL5Q9nWM9eWIfscX+u0uxkROexjYKgNFfhIWoBdVoO+BcXh0vLzOF56C8Bh7
 M9A9J5e69+REaRSLIQv7ftDXJBhXujj1fM2Amy1v/chzg3RToGEOzbdqf9TAbejOVepj
 ezPg3xu/NVL/pTmRC6ad3hJCgnXby/awsgyHkXdASyYTO/tRFKVP1GFKGRDclrlz71+D
 WPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718610; x=1780323410;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8p6PbnUhU95hpAtv9mfUJb6dg7Tc9KVwuspNrgFqyJw=;
 b=VQtd7SkFj3+qb+9+72ldidpYR2vb1LVgzVLZXYht6iPnTb05ZowtGtTuKYEyhqAH3/
 68JrTf3B+UMv4SSIQbiROuaTeYmmC+9qLkOaGMkHBZ2JedJwEK6CJvHSqvDvRKwYJkiq
 xYGzJtfTTeY7qlan8LyOn/qosh/NY2KZa7PgqUMSUVTjfwF7+wVRlUkYT0MZkDJJSrMK
 0M9b5JaWV3bonvKsZ1yoJgSTgg1uELuzYjvkE0VJ0JHfoe8WtrGADQTPceETa0+Hjvy4
 8uGRJm/emtQW6JF2OEobFXQ6HfNWXZlRzsS+YRGc6SflXlfGCiGQ6C+TgdhguH2CmjgU
 5blQ==
X-Gm-Message-State: AOJu0Yz5r1b3HGSv1eU3n1mCrpUgIS1u9G5OaZenINpAT1flumeWgpJ+
 Cjqv4TxnDkhzfSEHdH8PWos7XzqRAccE7KxS4+GdTynwWf67qS+0XAEK//Mibmr7Ve9o0+MkaBG
 ah+hScn4uaYU1nyE+kef90x9XAVjwIKZky5pjSIbUNQ0hBObngNGUEm5N
X-Gm-Gg: Acq92OEI68GQ149xkMMH4XU2+dLUalXzPTjsq/ijLXyQsoJh+ESE12ka8voG+KrbdNt
 klkJ5tvLxwfjlSBYSr+pbJoV98t6UBXiDrBk9Acusnhq8t7Wx2g9VDMZyrCl0Fw5FLLXMEdwBVC
 ig2PZ3qm/aQHd8TsEfq3lub6dzdvWqp5p1ZCcVWFLCDHtxmUBXWm9Gt8E/mvpJiwV534nVUFue/
 +2nY8cT11D2jrJJS25LZKSshMHDLfggkXkDrkytLPUMArGEraOZ594WL7QPJ1kKLQyoUbjM/xZc
 D6Gr7JeW9A8evJnlQcf+o13xDIYAfu4Fb/m3h+5dPd5ksUV6ZYRt9FkrNPY9CtApc/X/FUFvOs/
 JD/xpoG9UegteOfX754JSUw0V/useunoYUAwqAVc8LmTKAPlSXvKdAkkd0nBMKJlx4BjqlA==
X-Received: by 2002:a05:620a:c4e:b0:8ed:d906:a8fb with SMTP id
 af79cd13be357-914b48d56afmr2134093385a.15.1779718609527; 
 Mon, 25 May 2026 07:16:49 -0700 (PDT)
X-Received: by 2002:a05:620a:c4e:b0:8ed:d906:a8fb with SMTP id
 af79cd13be357-914b48d56afmr2134089185a.15.1779718608935; 
 Mon, 25 May 2026 07:16:48 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914bb9f199dsm1002464285a.36.2026.05.25.07.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:16:48 -0700 (PDT)
Date: Mon, 25 May 2026 16:16:44 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] igvm: fix handling of optional variable header types
Message-ID: <ahRZH2bUbuQnirr_@leonardi-redhat>
References: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
 <4ED1F4C8-B56E-4997-99CB-C509629F13C7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ED1F4C8-B56E-4997-99CB-C509629F13C7@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

On Mon, May 25, 2026 at 07:37:55PM +0530, Ani Sinha wrote:
>
>
>> On 25 May 2026, at 4:26 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
>>
>> The IGVM spec defines bit 31 of the variable header type as an
>> optional flag: if set, a loader that does not recognize the header
>> type may safely skip it. If clear, the loader must reject the file.
>>
>> Currently, all the types with the optional bit set are not
>> recognized as valid headers.
>>
>> Implement optional header handling by masking bit 31 before matching
>> against the handler table, and skip with a warning any unrecognized
>> header that has the optional bit set.
>>
>> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>> backends/igvm.c | 24 +++++++++++++++++++++---
>> 1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/backends/igvm.c b/backends/igvm.c
>> index c347d0c17e..408917f826 100644
>> --- a/backends/igvm.c
>> +++ b/backends/igvm.c
>> @@ -26,6 +26,7 @@
>> #include <igvm/igvm.h>
>> #include <igvm/igvm_defs.h>
>>
>> +#define IGVM_VHT_OPTIONAL_BIT (1U << 31)
>>
>> /*
>>  * Some directives are specific to particular confidential computing platforms.
>> @@ -139,8 +140,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>     const uint8_t *header_data;
>>     int result;
>>
>> +    /*
>> +     * Bit 31 of the variable header type indicates that the header is
>> +     * optional and can be safely ignored by a loader that does not
>> +     * support it. If the bit is clear, the file cannot be loaded.
>> +     * https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.html
>> +     */
>> +    IgvmVariableHeaderType base_type = type & ~IGVM_VHT_OPTIONAL_BIT;
>> +
>>     for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
>> -        if (handlers[handler].type != type) {
>> +        if (handlers[handler].type != base_type) {
>>             continue;
>>         }
>>         header_handle = igvm_get_header(ctx->file, handlers[handler].section,
>> @@ -166,6 +175,13 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>         igvm_free_buffer(ctx->file, header_handle);
>>         return result;
>>     }
>> +
>> +    if (type & IGVM_VHT_OPTIONAL_BIT) {
>> +        warn_report("IGVM: Skipping unsupported optional header type 0x%"
>> +                    PRIX32, type);
>> +        return 0;
>> +    }
>> +
>
>I think this check should be at the top of the loop. If the bit is set, simply return with that warning message. No further processing is needed.

IIUC, in this way we would always skip optional parameter, right? My idea is to
always process optional parameters if we support it.

>
>
>>     error_setg(errp,
>>                "IGVM: Unknown header type encountered when processing file: "
>>                "(type 0x%X)",
>> @@ -787,7 +803,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>>          header_index++) {
>>         IgvmVariableHeaderType typ = igvm_get_header_type(
>>             ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
>> -        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
>> +        IgvmVariableHeaderType base_type = typ & ~IGVM_VHT_OPTIONAL_BIT;
>> +        if (base_type == IGVM_VHT_SUPPORTED_PLATFORM) {
>>             header_handle = igvm_get_header(
>>                 ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
>>             if (header_handle < 0) {
>> @@ -947,7 +964,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>>          ctx.current_header_index++) {
>>         IgvmVariableHeaderType type = igvm_get_header_type(
>>             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
>> -        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
>> +        IgvmVariableHeaderType base_type = type & ~IGVM_VHT_OPTIONAL_BIT;
>> +        if (!onlyVpContext || base_type == IGVM_VHT_VP_CONTEXT) {
>>             if (qigvm_handler(&ctx, type, errp) < 0) {
>>                 goto cleanup_parameters;
>>             }
>>
>> ---
>> base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
>> change-id: 20260525-igvm_optional-ca1592b613be
>>
>> Best regards,
>> --
>> Luigi Leonardi <leonardi@redhat.com>
>>
>


