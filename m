Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D525BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 17:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOKhI-0000X7-KL; Mon, 01 Jul 2024 13:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOKhG-0000WV-3z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:20:10 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOKhC-00076C-Df
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:20:09 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-700cbdd90fbso2065812a34.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719854404; x=1720459204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLafzPD4+o7L9BONHQJigvjra9vtU4GZJHl2NO45MAE=;
 b=kb4UBPPlYRDkDpmH3KYm6QzQdEJu76kfX/y36wW/wGEVZNYc3r52REGlxxuLoAETpB
 Dvu0P1X3cua55eN69V0rVMgaWbhnmjzHEs10tlW1rsrvrKmFzkgXNZScmn3W2wcR19Y6
 frYQvfVvor4NX2ALOzt+ZsyNO413F6c8k3RHrpVNxL/RaHPJahOslLIEhedne7ajl6Ab
 ES+T661y3vlC7+NHT/Vb3ix40+bXZzhCHGsdRZ5Z2RWx8KupZu9I/3OQ2vq7JEO6HrpB
 dNExqOwq+Dc96446qksaU7pZTpEEbYY9WDrjxuIGa/T7ESK4cfIPfDabt18EWIIi5Rc/
 0KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719854404; x=1720459204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLafzPD4+o7L9BONHQJigvjra9vtU4GZJHl2NO45MAE=;
 b=tVfJMP66Pi/rhtilNm1NxUEz5WSmcqJhD/Nu/Szm65+y/c3tTe3DOcPmVlhNyf8s8r
 fwY9D5bpt8i58KeUIct5rb/ZU4XpD2iol4rPH/YtxxdOOjfHMMuhK19WZSy7E7Ttqzo0
 VrlS90xzSpCk9Nft4JepnKZlXCyBgyHJYDk5NqTN+I0NLFRxe03D0l/YNk2r7ZJncAc7
 /9/VlxKJxYMZVS7Fk0j0ZYOBKBpzCSAjOYJgxdIwOttpSuEVMvZeDL4xHaRGjFsHu5g9
 2kTKtAy3ABJdysilZ2gwjaAUgzoHOLHHU713lHEoJxjMqAjJu/57ebpGrzgvNfJWOuc6
 Jo6w==
X-Gm-Message-State: AOJu0YyRJYgV6UGEGRu5H+mqZU1kyoJfCw4hnd+FzZZdjSJS30YyJBxw
 MsU9+Wsa7euPYk+2iohkWqOnk8RDf7zERdWQAtdaNtMiY2bfiyYay9pEJXbzir0=
X-Google-Smtp-Source: AGHT+IHFu9ECu1+AvGqa/0Nh2N0nQc9s8Q99wNYBrtUxzv0z9F7I5/CkOA9GDOSaKCU+Sg55j2LthA==
X-Received: by 2002:a05:6870:14d0:b0:259:89cc:d80b with SMTP id
 586e51a60fabf-25db3567bd9mr6186124fac.32.1719854404531; 
 Mon, 01 Jul 2024 10:20:04 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708043b703fsm7007856b3a.145.2024.07.01.10.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 10:20:04 -0700 (PDT)
Message-ID: <3930ea14-177e-4777-8db7-42dc5dac33e3@ventanamicro.com>
Date: Mon, 1 Jul 2024 14:20:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] system/vl.c: parse all '-accel' opts
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, ajones@ventanamicro.com,
 Thomas Huth <thuth@redhat.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <CABgObfbVJkCdpHV2uA7LGTbYEaoaizrbeG0vNo_T1ua5b=jq7Q@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CABgObfbVJkCdpHV2uA7LGTbYEaoaizrbeG0vNo_T1ua5b=jq7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/1/24 1:31 PM, Paolo Bonzini wrote:
> On Mon, Jul 1, 2024 at 3:30 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>> My initial intention was to fix a problem we're having with libvirt and
>> RISC-V where we can't set 'riscv-aia' by appending '-accel kvm,riscv-aia=val'
>> via <qemu:cmdline> in the domain XML. libvirt will add a leading
>> '-accel kvm' in the regular command line and ignore the second. But to
>> fix that (patch 2) we must first guarantee that we're not mixing different
>> accelerators.
> 
> I think you can use -global, if you tweak qdev_prop_check_globals() to
> also allow descendents of TYPE_ACCEL.
> 
> For example:
> 
>     ./qemu-system-x86_64 -accel kvm -global kvm-accel.kernel-irqchip=off

I'll try it out! Thanks,


Daniel


> 
> Paolo
> 

