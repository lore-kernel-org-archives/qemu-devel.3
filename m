Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0574C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyI8-0006W0-Fy; Tue, 11 Jun 2024 05:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyI6-0006VM-Lk
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:59:46 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyI4-0004d9-Sg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:59:46 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6f177b78dcso270279066b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718099983; x=1718704783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9YXmo3CRVR8RoBeLgk/6TvQpS4uvHDIPiwNG3ECCLdI=;
 b=aTjboZGJ58mHYU/wb/A8FExuLBL7u7u7P0zBcZCMY0aB5VyIXccNCxryMddXNVHjZE
 SYv4hV7FPPjBZKY3KT4V80/8+x1HEIkbP4RTvSa6CWx18zCuixpYG542xP2rXaMITuF1
 AU0+lFMYr9zuQJJReSvCemUhAAl4flv7kD1wqFK51NYRYVp8gPne2c/fGSl+IRhHBKFp
 KueqsbZYoEMIBzzh7TM3oVIJOfYrthv9u11rEwwYms4M9oEZSfF938zEJlVBedNVgamR
 EZEyrusTCWosCpOyecsXlh5O7jujzzhCVA9hkMJYmUeAK+6J9DjuAZzfP8cwNRvD642R
 ZAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718099983; x=1718704783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9YXmo3CRVR8RoBeLgk/6TvQpS4uvHDIPiwNG3ECCLdI=;
 b=YtUY7WG575jNPsx6gQOAhGLvNdIS25k+ScbOwSiDXPBDQIOqjdnwtujgjVZMVFXVKT
 IZ2vkBVfI/B6xySRQWiuCUCZBkT3u2nlLlFntd0H5f93YoH5Jy6rkXMJMPWJLetBeUVB
 zT+5+kOGmQNispHra77eCcrQH2Y5XXtr+TJ3AgIBH5fvXIfx7tt5Cm0s1SFu+pcklX8w
 EK+NdSLwRMcbUnBSZjBHS8CoVrtThTDYgoAJzsZnMtz/LDPPAAgUGGleatwEkdz/juJQ
 wrZXhVsyztO94rYr6UTOU1LXp5fkK9mYL/V2TJSy4aeRTTMyJ+deWlZINC7A27ZRbSaN
 QePA==
X-Gm-Message-State: AOJu0YymM72UQZeMPjyBwcrY/DB0ZJEmsodLHHcC9/+rWBQ1oc5uLRnG
 +LnVcs0QGWU3Pykr+ueR2mFh/kNJH3/AeNTcWG1y4eZqVOXmTz9afzP3bLHpMLc=
X-Google-Smtp-Source: AGHT+IFE2KlPYg1WsxJqEY1LZOSpkQODfDN5U0VESCb9cIhxddtq6sxAchmyxy0WkkUJJoU/LFB1og==
X-Received: by 2002:a17:906:c0d4:b0:a62:1347:ad40 with SMTP id
 a640c23a62f3a-a6cd5616b72mr755025066b.16.1718099983069; 
 Tue, 11 Jun 2024 02:59:43 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f335878cbsm99484666b.214.2024.06.11.02.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 02:59:42 -0700 (PDT)
Message-ID: <cc648a89-c1ba-4cdf-ac7e-b6b4e3c9e263@linaro.org>
Date: Tue, 11 Jun 2024 11:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb: Introduce x-query-usbhost QMP command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Don Porter <porter@cs.unc.edu>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240610063848.51027-1-philmd@linaro.org>
 <Zma6S1bHmE4oGKhX@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zma6S1bHmE4oGKhX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 10/6/24 10:33, Daniel P. Berrangé wrote:
> On Mon, Jun 10, 2024 at 08:38:47AM +0200, Philippe Mathieu-Daudé wrote:
>> This is a counterpart to the HMP "info usbhost" command. It is being
>> added with an "x-" prefix because this QMP command is intended as an
>> adhoc debugging tool and will thus not be modelled in QAPI as fully
>> structured data, nor will it have long term guaranteed stability.
>> The existing HMP command is rewritten to call the QMP command.
> 
> 'info usb' host is one of the problem scenarios i mentioned in
> 
> https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/
> 
> Its HMP impl is within a dynamically loadable module. So if you
> run it initially you'll get
> 
> (qemu) info usbhost
> Command "info usbhost" is not available.
> 
> 
> but if you have a usb host on the cli:
> 
> (qemu) info usbhost
>    Bus 3, Addr 6, Port 8, Speed 480 Mb/s
>      Class ef: USB device 04f2:b74f
>    Bus 3, Addr 11, Port 7.3, Speed 1.5 Mb/s
>    ...snip...
> 
> 
> Anyway, the end result is that this patch fails to link when modules
> are enabled:
> 
> cc -m64 @qemu-system-x86_64.rsp
> /usr/bin/ld: libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-machine.c.o: in function `qmp_marshal_x_query_usbhost':
> /var/home/berrange/src/virt/qemu/build/qapi/qapi-commands-machine.c:1514: undefined reference to `qmp_x_query_usbhost'

Indeed I missed that.

> IMHO the solution to this is to refactor the cdoe to split
> hw/usb/host-libusb.c into two parts.
> 
> One part provides the monitor API impls, and some callbacks
> for feeding data to them. The other part provides the actual
> impl, and registers the callbacks needed by the monitor cmd.

Yeah something like that will do.


