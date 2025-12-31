Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99F8EE644C
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vazR0-0005JH-By; Wed, 31 Dec 2025 11:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vazQy-0005J4-Dw
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 11:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vazQw-000311-HA
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 11:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767199944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5MmdG+6Q7D9kkxJ2znr8bPome1gjWobQ1lBi24L1C1Y=;
 b=XPeC45J2NOIODAtKmCpE1LygNhwEaMOcLMOuOoP9JPt6f21fkTDE7SK8CoPDFWZuFO4xCK
 6vqN5UDJjJ1dveyZ4ijImH30WdcoCftd9yhM6uz7JP+IahELW2kXFRMkf0S6FWCKEPhvG9
 FmjZIPyF3VUiXLgZ9AapZhi36+02g+g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-GhjTzNvBP_qYLOg_Uxyyrg-1; Wed, 31 Dec 2025 11:52:22 -0500
X-MC-Unique: GhjTzNvBP_qYLOg_Uxyyrg-1
X-Mimecast-MFC-AGG-ID: GhjTzNvBP_qYLOg_Uxyyrg_1767199941
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so5425221f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767199941; x=1767804741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5MmdG+6Q7D9kkxJ2znr8bPome1gjWobQ1lBi24L1C1Y=;
 b=QUNOsH5W2RggCsm9JZHeA9GnJ3Ni23pw/ns3uxADk1PRl5VPZ6Le9a6XZA9flHDPKz
 4vUZdorxOL6s0Kyx/zKQy6AyG7hdpcu9doZNekgghgIxee33eIw+JDiwRUmReHH81oHI
 UlMS4nGThtloOzGXIMS6AjRdvRTvVxsyusq2o+E35tFzmJ7QV5iixupvbINd4QPa50yP
 Wf7HtGXAhLb3bLkdQKb36H6EB2x/4skaMV/dIQg0x2yowaqESECWGe3g9cexkv6YfD20
 IiKA2G3GSYdZfO/tV7uVLsH7dTcDBRn7IgpC/PARK90HwITwbn0Bj2Iyou1fd3s+jWq/
 yj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767199941; x=1767804741;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MmdG+6Q7D9kkxJ2znr8bPome1gjWobQ1lBi24L1C1Y=;
 b=gsPmA4IixzNOVafay6Cti9I8X1SbuYT7Ijv69BZvxldNEiwaOaX+xgrGULZj1VEaUp
 jrU+1Sje+OrQ4+S3S+H6UFVtJmVi6x2bseAryTEt8iDnER0OApabMJhCGBkOpRPGwo+Q
 JKzT8JgLi3oipc+V8QeN1XFl4pSyT0jd8DXjFq1DePazGqShmrwHGNZQ7B7X5q7O6l0A
 0MPxq8oB8EItCV0A3tzC5TVlqigoLbVfFNyowuHUqoeoT+rpaJkZ9L6IwZ6IbUlVY9Xs
 RbiodB4u7xs7q4ccXMsdzQ//QNFDZiIp+V7nbrREQzlkIoHnT/WOeh3+/zeD7ZrP+7u1
 5zrw==
X-Gm-Message-State: AOJu0YwBksxJCsfB8ILDds7L/3N2Fx7ymn3AV4xwKBo9izoci424tZAg
 orXecvr1yIf5RAGae49dMjiz/kfVwWzopidr9b5DfYDBd7m1dKjF5Wa2+szKVEqI4SJF68XrZ8h
 GLJasuVWbDtRxncNBcZE/3ZqBMnATJIgpD7ZhhgbC6+BBhYks4b93+TNg
X-Gm-Gg: AY/fxX44zr0GTOOfRrvc1whFotQE1tIagBU+y1GLo3E9ffZkQB8ScNCG9ntkcyaxFEW
 bO939PNc2Zl7ymMHd2qKlXfgNxA258qDTJMcaqTi7jk4HhnF/Xq2WkT8Nsuakir6akS4brj3My9
 nYsMTlb2xZKYzvvDrq1Rexmvb5AMw+Ea6tLWo9iOnTwTxQ/aTqJ1l3aQWn3xbviYVT/GWdhs0hM
 nxotwR2oytRwIvJyVrOvccHDa/IzgPysUPuHlmc0Tjq62RrzafTdv//9Ar/VlApoqOjwI2xQc4W
 NBBA9gl2FsYF2o93wh/2tfVvn5m0yDgsWFc1XNJ0XdzlmOj2cIT3DBIgixK6U+igbXR95HC0Dhk
 GE4ynh29OnU3C7vYkiCElrdO0ZxG4fG/FKbUiytaRNNHF6Pvk4JBMj+4db1bIVFmk8tmN9x82MP
 1dMWBFCSwR0nl6sA==
X-Received: by 2002:a05:6000:438a:b0:430:f1ae:c7a9 with SMTP id
 ffacd0b85a97d-4324e4cbed7mr43773446f8f.22.1767199941283; 
 Wed, 31 Dec 2025 08:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx7mcifYEAqmsuxDb4l9uPHKi3ywGUXGM7wFEBu2Py9XM3PzCM79d2UwJMa0SJjyd6+6BzHw==
X-Received: by 2002:a05:6000:438a:b0:430:f1ae:c7a9 with SMTP id
 ffacd0b85a97d-4324e4cbed7mr43773432f8f.22.1767199940903; 
 Wed, 31 Dec 2025 08:52:20 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm76233321f8f.32.2025.12.31.08.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 08:52:19 -0800 (PST)
Message-ID: <57659016-d636-4322-9013-48610460bf4f@redhat.com>
Date: Wed, 31 Dec 2025 17:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/i386/tcg: commonize code to compute SF/ZF/PF
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-17-pbonzini@redhat.com>
 <f5bd56df-e586-4cce-9325-8ce9ed702e4d@linaro.org>
 <CABgObfbBacG=cFv614S5CAj-pG=-x+EdaQO5G0aW_zhR8YA=Gg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABgObfbBacG=cFv614S5CAj-pG=-x+EdaQO5G0aW_zhR8YA=Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/12/25 16:45, Paolo Bonzini wrote:
> 
> 
> Il gio 11 dic 2025, 19:46 Richard Henderson 
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> ha 
> scritto:
> 
>     On 12/10/25 07:16, Paolo Bonzini wrote:
>      > +psz_b:
>      > +    shift += 8;
>      > +psz_w:
>      > +    shift += 16;
>      > +psz_l:
>      > +#ifdef TARGET_X86_64
>      > +    shift += 32;
>      > +psz_q:
>      > +#endif
> 
>     Oof.  Use cc_op_size instead of a set of gotos.
> 
> 
> I was so proud :) I will check what the code produced with cc_op_size 
> looks like.

Sorry for not following up, without cc_op_size() this is a simple move 
instruction in each case of the switch statement; with cc_op_size() the 
compiler does not notice that the value is always constant.

Paolo


