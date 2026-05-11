Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B9CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8m-0003CI-89; Mon, 11 May 2026 16:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMX8f-0002jL-Cc
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMX8d-0001yp-4l
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kwxmVGjP125hP75M8A3FoLqLqZpWocGSXisDiM6Pqdk=;
 b=jSOnxUj5fkaaUzfsVW3N5bVWu6uvN3DMs5zLmZEeQolXi/SBRFG2xXhpYk2KbJDVHHmSue
 njHRi0lh+Ga+V1HFcVnowGKXmijWr2NN76DgrMDOHCxMIyc4t6Rvp3GKjchQs+HoHhTdgL
 ifIdjx+ahJ7aGJQYLGNijdabaLQpkaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-EqbXXelFP2enA-U8Gu6-Qw-1; Mon, 11 May 2026 16:21:58 -0400
X-MC-Unique: EqbXXelFP2enA-U8Gu6-Qw-1
X-Mimecast-MFC-AGG-ID: EqbXXelFP2enA-U8Gu6-Qw_1778530917
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a122a5128so3625119f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778530917; x=1779135717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kwxmVGjP125hP75M8A3FoLqLqZpWocGSXisDiM6Pqdk=;
 b=KldPCZSPMgvA2aezwenuZhnCm3/u0ERlj6o/STEReuVoMdIs4QpOsVt018q40166ef
 iXfzeo8Am7ym91ruyr9ly8MG+xuaXwGyz6mazVeqpKfkrG3Fugi6NQYLgYw/X8S8jRai
 FBq+mcXX8TPQl+1jClLBqaKFOPIQMPsr3XNA6BAH8vvExpkNHaL+W2UoKU6UzC5aBs36
 0OmjxMo11NdSIcr7VcxF8mmguG8cYeWyYwpq6FUXI8Q5+4+NjU1dArJTjJNJql8FYwZ4
 onNOI+FRBMp1/4Wub8dsMMnBJfmwqDzrt4mzopvf2D29KGkxdHwSZjF1B+Xe6AeEBHFc
 AcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530917; x=1779135717;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwxmVGjP125hP75M8A3FoLqLqZpWocGSXisDiM6Pqdk=;
 b=Hwg2AchgBSVX7ZjglhnKbEPk7q8MyCZ3fKQQ5lDuY2xyoFEus6qURVgyIpuknaw4C5
 HOC3dqvdf9z2Ij8wuy76AjvP5JXbGfV16cOjjAov+kre1o1YC7KQnZWmZQl1zt1k/cRi
 2Ts5sufZc7jMYvnzMD1Z4d3CTmu9CUPPuymipdg6QfH30F8xKTDdPHfEZTRw4E4JJmOr
 Qm45rVvyiR8ZubJPagYV6vsJ8P0lA368Zzq6yjQ8Z63AWGpAwSsxQQHSj5XR9yG0B3YY
 LpXI6arQKO0gzn2ws1o3boLgbMWFyw4ml38DTAFvWNlsAgYtWiP/BzDXRPR8ymy+nqZk
 39pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YNXr01qZFmQMea3rDakqum3Dk7+NxlQERc+WE+ICSIZ7Serwzegb9Xwk6yvnkCBglHgTLlIUYweXB@nongnu.org
X-Gm-Message-State: AOJu0YzYH/bgu4opQGTmu01+4cOSVPH3IBRoxMrwQMES5Qvcec+EAsTj
 NfUOyyC8FZyOJKkdGI66P3TIpc0jcewbRiKn98J+f1hELVGJwW87HyNTMkgnCcz21RdHxnIIYb/
 ZmHBi1qP5uZtaoJjySC3k+c5Awqvv/USJap6iSTmOhLlzSfGfNOtBE7xU
X-Gm-Gg: Acq92OGkbxwzoolF7S8s15N3TckEMXz4zC1PCBnjtrSUsJ2AURdBlg52uz3sm8eFJEi
 23Za0rCxEf23zfpQR3PQVbOCKn685WB4uItzHhuLNXFEjPO3El4PHQE8KIpFa7Pa4i26mg/LHv6
 9uut8prhjBtqUBqvBUI0sHPdhGyDk0zw67xqHrxFFSEhC0WzD3OTTVYy3Eh5Q/69tkL1vJ6Bo/q
 Zho1M/9DxX7pn8+SMKfWcQtYQU+RcdEVi0rvNfR8agpkz9hMsGMVbhRIYIxd921s4jOwQt4vo7c
 fXsXZsYMKajUC3E3AM85N3n8KQLch3j+FNlgZk1EFJu+L07ay5Wo62nnHe8hEzIy/Sc3Z7jqFe4
 JPrLSTWx4KgzNql42zL4J1yEXzJAvgbbUwosZ2VlpTcgPYF61jJdFvRTkcgwU
X-Received: by 2002:a5d:588c:0:b0:451:bbe4:b48e with SMTP id
 ffacd0b85a97d-45460e406fdmr24171962f8f.5.1778530916954; 
 Mon, 11 May 2026 13:21:56 -0700 (PDT)
X-Received: by 2002:a5d:588c:0:b0:451:bbe4:b48e with SMTP id
 ffacd0b85a97d-45460e406fdmr24171937f8f.5.1778530916475; 
 Mon, 11 May 2026 13:21:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-458b3664e3esm12083129f8f.3.2026.05.11.13.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 13:21:55 -0700 (PDT)
Message-ID: <45b8ef38-4a39-452c-8200-938818d633f4@redhat.com>
Date: Mon, 11 May 2026 22:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
 <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a57d5120-dabf-4953-a680-a9c875ecf238@linaro.org>
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

On 5/11/26 19:48, Philippe Mathieu-Daudé wrote:
> On 11/5/26 17:48, Cédric Le Goater wrote:
>> Hello,
>>
>> On 5/6/26 15:55, Philippe Mathieu-Daudé wrote:
>>> Introduce a source set common to system / user. Start it
>>> with the files built in both sets: 'cpu_models_user.c'
>>> and 'gdbstub.c' No logical change intended.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>>
>> This change introduced a regression with PCI passthrough which
>> stopped working. Guest kernel reports :
>>
>>    [    0.156501] zpci: PCI is not supported because CPU facilities 69 or 71 are not available
>>
>> and other devices (ap, ccw) are impacted too I think.
> 
> Is it something we could test with the mainstream CI, or does this
> requires specific hardware?

I think you need a s390x LPAR with PCI adapters. TCG won't work.
Not a very common system.

C.


