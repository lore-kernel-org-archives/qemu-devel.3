Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24B1C44521
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlil2-0001qh-AV; Mon, 20 Jul 2026 03:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlikz-0001qH-Hw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlikx-0005xr-O4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784533782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=knjdhtBAVjdablLNVmiBRHa9Qm7l+WbC//o1s6JKwn4=;
 b=RgZhN10Pqg/zO2wdCjwiOuT9RwKlJzxzA5bfS0Xy7i5FKTcsK8/zo14pwOrqHmpHVqWkl8
 tSr7Zmspn1VSYoy3bKzii4Jza2aePWMdTPSPatE1WXl1R4OHf14n9br/sJgaCDbK9EntDb
 8THT2rKVU6l2rnknnW6c6/wfez29MrQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-PchkIS6vOGOYzx02RnibPA-1; Mon, 20 Jul 2026 03:49:40 -0400
X-MC-Unique: PchkIS6vOGOYzx02RnibPA-1
X-Mimecast-MFC-AGG-ID: PchkIS6vOGOYzx02RnibPA_1784533779
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f70ed473bso73870f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784533779; x=1785138579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:to:from:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=knjdhtBAVjdablLNVmiBRHa9Qm7l+WbC//o1s6JKwn4=;
 b=lQyjt6sZTy+Y9AjezM6x+SSoQDdrg1ikkl8wwnhGSuxGb9FTLdiBTa1VfjNsoJWEiw
 is00b+6Gg4Nodu0Udy/TiTKITtr5je1PdO3ELtzqb+jja0yCSS2jvh49OEBZPBFhkql8
 RbxXYMV9Tca3mfPN0Ob0dxoX/tIC1xexGnY6RWSuyGWgivXpRemeLUUnBx273aEQiQFT
 Q14T9BoW4frX5yooaesW5ppCbMr/q5ixLJczEaBgvBLTP9RJws1PDLlyrau7ILHY2HS6
 IBTglZx0qmeQ9aNhObeMZjtVsa7mqsffXv0+7r8nrIhve/jOc1gG82r14nuDaCDyM9IH
 BSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784533779; x=1785138579;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:to:from:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knjdhtBAVjdablLNVmiBRHa9Qm7l+WbC//o1s6JKwn4=;
 b=RhXg4neeLb71bS70KgpAcJiwIOFFn3V4VS2ZVsqvk702O9kdfpTl4hRA6IqEIACJRa
 lpLT4Szm6zUXm+6AVTFiKYrcGKB6FibDlc7i7rxjLvC/im6g4lfHce+95ErO7BUJukfx
 MxQRWthwdRM8MJa7zYS6CQiZYEu+xY9QKMKvdW4chrbA70VFFosbUoAG52iy11PvdkEE
 oEoQy74R/7PjI5vHbLaaCeUyBackB1NjRh6a7CStYRbJqNch5HZOjUWwyeWlVU8rSdss
 zU6BaFj+cLhOyTnSZ1He6e8FAeYTuKUrx0S1VPdbnmesWztYVGRIJZQvjQQDSbJ7t5sl
 x38w==
X-Forwarded-Encrypted: i=1;
 AHgh+RomkQbzXu4y3KWGVeCu8K+epuHJcXTLRNwKP7rUUvcB8O2K7GsiUQBGkAsnBcz8CWMvGXgu5uz4ia+N@nongnu.org
X-Gm-Message-State: AOJu0YycZ9JX8itFVsXOGy6RG7vztOLKjSjbQMLZN6cYLYk8ekGPKk/d
 o0AF+4AYWfAFa8Agrd/AWDQP9Q2qGB/IytkNwFem4+oVJQXA1UVXTsl4PQH9Mw87HFWaB9fSui/
 w08YB/WqiE8tfHO9yTJ8MooaDFTRJGgrdP2QvTibw0K3ZI6in4RGmjrdB
X-Gm-Gg: AfdE7clULOrLTr3QbYPYm62c/K9DnkJWIvjBRCD+CvkMGrqZXBTxkfoYalmoTkqLdBk
 AicjCBV94PN1wHeDHE0cCjZzoruLuaBrDrIb7AMC3G8N8A08nLd6IOqe2hoF5gP8XvOBgqgnQYS
 GAQg+XSq1yleffWUnwPS5qtV4fn6ERgFYujASsinuSOn+8SrbbXuN9wj3B2uiBpEzp0TUe47wzL
 hq9N55j9z3FTGYF7YlDgu7wNWgKkAlHxUo0tTB3ImurbBX75UbbvkPX/6M1yyNgXtguSRsDqyjX
 pUrT7+ixrGSOkH3EZl5Ke+9dxX9SH98t0jOIqRIlBp6DsH0KWix0pHH9Xryz/Ko1LnC4XA8yZw=
 =
X-Received: by 2002:a5d:5e8d:0:b0:470:2fb1:3dbc with SMTP id
 ffacd0b85a97d-47f62325a8amr15353909f8f.35.1784533778877; 
 Mon, 20 Jul 2026 00:49:38 -0700 (PDT)
X-Received: by 2002:a5d:5e8d:0:b0:470:2fb1:3dbc with SMTP id
 ffacd0b85a97d-47f62325a8amr15353882f8f.35.1784533778503; 
 Mon, 20 Jul 2026 00:49:38 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm26556954f8f.6.2026.07.20.00.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:49:37 -0700 (PDT)
Message-ID: <6a97df11-6179-404a-8bf8-e3609c346f4e@redhat.com>
Date: Mon, 20 Jul 2026 09:49:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbredir: fix infinite loop and SIGFPE with zero
 max_packet_size
From: Thomas Huth <thuth@redhat.com>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260716141107.3597076-1-marcandre.lureau@redhat.com>
 <22e68ec3-c020-4a5a-9463-dfc66ed4b503@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <22e68ec3-c020-4a5a-9463-dfc66ed4b503@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 20/07/2026 09.38, Thomas Huth wrote:
> On 16/07/2026 16.11, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> A malicious usbredir peer can send an ep_info message resetting
>> max_packet_size to 0 after bulk receiving has started. This causes:
>> - infinite loop in usbredir_buffered_bulk_packet() where the splitting
>>    loop increments by max_packet_size (0)
>> - SIGFPE in usbredir_buffered_bulk_in_complete_ftdi() from modulo by 0
>> - SIGFPE in usbredir_handle_buffered_bulk_in_data() from division by 0
>>    when computing bytes_per_transfer
>>
>> Fix by stopping and disabling bulk receiving in usbredir_ep_info() when
>> max_packet_size is set to 0.
>>
>> Add post-load check, and assert() for the invariant.
>>
>> Fixes: CVE-2026-63319
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3995
>> Reported-by: Tristan @TristanInSec
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/usb/redirect.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
> Reviewed-by: Thomas Huth <thuth@redhat.com>
I'm currently assembling a pull request with some other USB fixes, so I'm 
going to pick this up for that PR unless someone else wants to take this patch.

  Thomas


