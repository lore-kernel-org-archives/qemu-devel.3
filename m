Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A13AF99342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFoPC-0006NM-J9; Thu, 23 Apr 2026 03:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFoOw-0006Mk-09
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFoOt-0002zU-Vz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776928981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fMjkC+VFKLX8KSTR9hbt6j8CndZlGYnfpnlSAGo9LxU=;
 b=LAq+37wR4JZBbt3Bfn0ZfXwqnmBHJtj7loNQFP+1L442UrkgyrDZX6JbMJsi7oDYT5GnFJ
 IVvymo+/IDx9VelzJowWnDH7mwr48JRpH5ZRFPu19oRE2pfVH/urkLg87DXd2SDEFQiuJq
 CIDMOt4UOxJb5c5Xazzjzt/IdEzatUc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237--J5RiPzaPXGggBddBYzblw-1; Thu, 23 Apr 2026 03:22:57 -0400
X-MC-Unique: -J5RiPzaPXGggBddBYzblw-1
X-Mimecast-MFC-AGG-ID: -J5RiPzaPXGggBddBYzblw_1776928977
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a5952c635so18838845e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776928976; x=1777533776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fMjkC+VFKLX8KSTR9hbt6j8CndZlGYnfpnlSAGo9LxU=;
 b=kEQpYgxnHKkMwXqernf8xZ+rdx7Mxg7Lc3rKYkUdNgQhW+mvdP83LLeu8xx1iXLfrW
 +hVdLzF9a50HLvewoWpPsx314GLlCE5tzV7t9bN+Tu3ur+7N7iWq9pz4euqqKkZDp3Y+
 iMhorwP27IqQfU2vKPLjJuZFyvHNnz3RaPFCwEeKi0DnxrEIKR8UsbOXtNngONtuc/Zx
 2mMaFgZXPwp4KO+XqaukcN2KV1fJXP+7ar+R8vXpdCtAgcs0kiVVqxfUpnET5BT5l9G8
 hs4b7fQPWViKEP3r5pcCXYTePgv52yrD8kOkwqz6ao6ZmLMQ6XUeNOG7H3XT6d4512cY
 Ab2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776928976; x=1777533776;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMjkC+VFKLX8KSTR9hbt6j8CndZlGYnfpnlSAGo9LxU=;
 b=PwaJ3uXjzVeLnlDLAVF4LNY0wltN8OB1zNgWJSX+r+OHfdFDb0R9z2JIryUFETxCHa
 u/f1oHMxC+QciVu1xMsFqVYPaqH+sA5uL4hGIbsPoeaumznSNSXKRfHo1HCLW8Q5C/8O
 aorWeAiwzCCcmWBSW5r6lo2JP3MtIvd3AXeampFQlnE3XHTuIae4Ntqh9Cp//sIg1hf/
 6N6UAUBZniI34FCpkMzIKVVKC5vk1N1QJmQSTqQTWlCjIgfpHWlkqOhTMAAcz93Q5he4
 qvv072/jrfAoNW7jzPzDqvoEaTQZxPyZhBvo4tVMHqD0QR46g0TlOcFXaY4AowUybCGh
 ehPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oiStUGZlnt5p8dag8CREO/1VeghbKjm9VHZjFkzhxYdgTk6rpGi6LRy83Us1XJIQ944jN5ezqpGoS@nongnu.org
X-Gm-Message-State: AOJu0YwEtCWBc3dwg6zkHFqySbG3td0BFstKjpXpa8foUopS/7QtCof3
 mrHDo1OT9lRaiiBPwYt33qOGznTjEbcaUt1K3u3DbUVjyLJ0z+H80BpazRLxRmrHVtnp36kRstH
 2ggf42G70F06/BsFTcJAxraP8SlTsLh+mqh9RUll2y+yiNefvhX7ompsw
X-Gm-Gg: AeBDieuJEM0ir17zNSyRviKT1SFc+yTqACzSRZenqLD5QX5YmhQy2juqUPMUJyU/DxB
 Ecnf8gqp1Eedncfgg0oXE+UrxFkBvujI0hsPzPRGU/n4mBDdX2Bc5dN3ZHP1OMaWo6hw3pWlaDP
 7yhWo7JciXnvE9lIRY1PbOguuJ7IpWVfToNVRsGs6ywWASmZyGh7yjaThwfA9c+bFIvl+D0zb4f
 Ev8E1C8//58YYGFusM8Ny9Mq8E/Nk/jv0cJUsldpoJW/sxT7g79Ih4i/JJuXg9FM7rGRQ00yFp+
 aoHtqm5Giol1wsVEPWPGFOqpq5T3NFGJ8X4ubnPINLjHLWE4GnzaHkatmAoCQoJwMAhReYNg35w
 hYOHuKPtrPEZde1k2e+5IqGSk/2jVPIqNjUyhaU1qmFqE5kmDch1yLxc6QP04qEmNjP0o/Mk=
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr334196835e9.10.1776928976495; 
 Thu, 23 Apr 2026 00:22:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr334196405e9.10.1776928976065; 
 Thu, 23 Apr 2026 00:22:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm109911335e9.2.2026.04.23.00.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 00:22:55 -0700 (PDT)
Message-ID: <302ccce4-8e44-4412-9d66-e24abe046103@redhat.com>
Date: Thu, 23 Apr 2026 09:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-headers: update to Linux 7.1-rc1
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, cohuck@redhat.com, thuth@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org
References: <20260423012838.3695392-1-gaosong@loongson.cn>
 <20260423012838.3695392-2-gaosong@loongson.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260423012838.3695392-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 4/23/26 03:28, Song Gao wrote:
> Update the Linux kernel UAPI headers to version 7.1-rc1.

This change comes a bit early, as version 7.1-rc1 hasn't been
tagged yet. I suggest waiting until next week.

It is also recommended to add a cover letter to a series of
patches.

Thanks,

C.



