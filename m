Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75712D4A60D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgekg-00037x-JQ; Fri, 16 Jan 2026 03:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeke-000373-PL
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgekc-0004a6-CJ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768550409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EvHapu9Ad1IOoCWtEUfNDm0QwqwE5KZeXOwLP7Ya8yM=;
 b=F5CLLP03ZuZNaU0KZD1d/I2rR+2Yd8vjqB/RoVMQtMH2qc8An/tNhusAppmXCMUnnMzWM7
 Zf5fgaFSFhcgq/39dx7Y3RQC6BGTPqY5II75SWxOuGw4V9vZLvSsW9y6GIxMilV6zcLAmc
 FwZN1TXPHJSziONQuF1lAtQL3fXZcg0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-JgsCf28lPsykGKCoQhee4A-1; Fri, 16 Jan 2026 03:00:07 -0500
X-MC-Unique: JgsCf28lPsykGKCoQhee4A-1
X-Mimecast-MFC-AGG-ID: JgsCf28lPsykGKCoQhee4A_1768550406
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8711b467f3so466205766b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768550406; x=1769155206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EvHapu9Ad1IOoCWtEUfNDm0QwqwE5KZeXOwLP7Ya8yM=;
 b=UzX1Rd0lF8Q2rEx8Ib0L/r9xpw/r01whZA5Ri0s7pUkHereran/fuziscwsXhRP26A
 /fIIzvnHrfbC+EW78on4YlKzW2aBkoPhZJRRy6S6WJCkLOzcsZ0YzogBavB8gCYU7uHQ
 BviF1KJ60oHt41TkucObUam7tB8mw6z3jaYymIvRlnW4c8aa6Fk8AqWf8GUnGTE0YdjV
 Y8pWdTYPQzRjmqMqIELkmfnRXL/x+avCDuSgGiQH6Tji25d5OVR/7vbxAYSI+1sQWZXS
 2Qzi+iPecLZ6WO3JyH44TK8rhEaog43oMt6m90brvYVwPUII2C78Gs8oMxbZQu4kM57t
 Mo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550406; x=1769155206;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvHapu9Ad1IOoCWtEUfNDm0QwqwE5KZeXOwLP7Ya8yM=;
 b=YHI+yaHifzZ42VdgpD0N7jdgSBRJcYUgocAgbcuNfDosbyCm9/CQdAVS88TUQc+t1C
 QXacX/blXdvcwXwplEX//9ST9bXaSFpWJepHnGYzi+iIz1auUUCJ+/DX4uFY5+uexy/F
 hHYkrkE66eSfIUU5Os4Goq0SpLp2OahmZn99ERuf3zlbuJfypLroiqGo7qBvcE+NTzX0
 mz+ukqj0xddM5rnbVHY0mIy95KqlNoClEcBp5bodIazP9uve03w13X/um8QCEXCjhv7j
 qLzEWFqjR6bUK4cyb4ipae6d31whDZjvbhHdIu6W4i3sS2Y+hDOPBzWyV1UFcStuz4+o
 UF/Q==
X-Gm-Message-State: AOJu0YzmyboXHsIJDo5eQD14NFsDBRnn75EvDPCScNudH45xWyZTmvpd
 c5aR7Ythd3AQqyq/4HyhNldomG/j7i0scQYWqmCr4lyCsLCNhyKOY8BtN9Q7r7p9S3H15zRmMgj
 1EFjCFQ/6vN2R42tRr8GvDHBlLVCuKycvm52NQ7H+1VpepD1QrfUg4Syb
X-Gm-Gg: AY/fxX4VNxF2XVaXzIYEqFw+xmlo9q53uL4CLiWwqIgExSbCvG4lbeigMo0zrRtvkKd
 AL8ZU0SajiZgHX2/JsKjK/D/ezAW/ktLAP04edD//gxrUZseMphqqBz3Lwv9GFpSAmAI027+oDP
 6stc0Wd0geRNXYSOzatFglkUjqlUIRTqsfYTglTTpsX8eRQjzKSooZwRTAOSfZ7i5aG9/NURqQT
 0ZwfwwdUgfMr5hjhObN0gVr3aGjDdFEjI6uV3uUOpWW5/Zxbt817eKa3Zv744htYSQkwXAKFDec
 FAk3nsWms1K8CBpMwn3DvlDXmjLungxMlGs6D5JjbVgRKHbcuYSrFS6hk019kS/Sip0jsW42Ycy
 ueqpC7GU=
X-Received: by 2002:a17:907:bd0:b0:b87:7430:d5e2 with SMTP id
 a640c23a62f3a-b8777a59432mr369952966b.12.1768550406439; 
 Fri, 16 Jan 2026 00:00:06 -0800 (PST)
X-Received: by 2002:a17:907:bd0:b0:b87:7430:d5e2 with SMTP id
 a640c23a62f3a-b8777a59432mr369951566b.12.1768550406079; 
 Fri, 16 Jan 2026 00:00:06 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8794f93c34sm176641666b.0.2026.01.16.00.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:00:05 -0800 (PST)
Message-ID: <7d190ec5-9a15-4d95-a63a-4f25b7b13895@redhat.com>
Date: Fri, 16 Jan 2026 09:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hxtool: Split srst/erst add checks
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
References: <20260116005050.376616-1-dave@treblig.org>
 <20260116005050.376616-4-dave@treblig.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260116005050.376616-4-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16/01/2026 01.50, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> Split the SRST/ERST case and add some checks.
> This is mainly to make it easier to add some checks in following
> patches.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   scripts/hxtool | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/hxtool b/scripts/hxtool
> index 80516b9437..51dc841479 100755
> --- a/scripts/hxtool
> +++ b/scripts/hxtool
> @@ -2,15 +2,29 @@
>   
>   hxtoh()
>   {
> -    flag=1
> +    in_rst=0
>       while read -r str; do
>           case $str in
>               HXCOMM*)
>               ;;
> -            SRST*|ERST*) flag=$(($flag^1))
> +            SRST*)
> +              if [ $in_rst -eq 1 ]
> +              then
> +                echo "Error: SRST inside another RST" >&2
> +                exit 1
> +              fi
> +              in_rst=1
> +            ;;
> +            ERST*)
> +              if [ $in_rst -eq 0 ]
> +              then
> +                echo "Error: ERST already outside RST" >&2
> +                exit 1
> +              fi
> +              in_rst=0
>               ;;
>               *)
> -            test $flag -eq 1 && printf "%s\n" "$str"
> +            test $in_rst -eq 0 && printf "%s\n" "$str"
>               ;;
>           esac
>       done

Reviewed-by: Thomas Huth <thuth@redhat.com>


