Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171D3EE020F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGbA-0004Pw-Ti; Wed, 11 Sep 2024 02:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGb9-0004JI-EU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:13:03 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGb6-0008PV-JI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:13:03 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so566488566b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726035179; x=1726639979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nV2GkJj+s4ZXYPHgUeV+FAl58LUFuFK7PRMAYADUeA4=;
 b=ZEdgnZ2hl1kdgDk0v1W5SRMU8xL66HtR0VRoTV31qVBd/fw4jjHbllpxkTxh0bFChi
 1k+EoPfVEDjU/XTqfX4xbHVHTr51tnOPfhBtqM26KiY6nIISyO9oa7T6j831UcE2p59T
 zQiSwppD8T+jvsyfeJlamya8GkoxSrSDRRJl7KUBiY+riquXSrnVSn/AlkBZq+fcRTUx
 +HN+3yF11+EOXOr630I2T52PUkNG85O65ZIAXKJxtgAkRDL+n6PMc0mAHWPGREJfyJNS
 oANBFdx+e6Efn2+c0M953h+S7LBbhdn/YJ04PAf8M3JYZMygfPHxpvlnoTqCw79yKpEg
 WgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035179; x=1726639979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nV2GkJj+s4ZXYPHgUeV+FAl58LUFuFK7PRMAYADUeA4=;
 b=oCKbXCvaB7cDJuYNK2J6L5zQRVjpcrly2GRpoNSc2Uws3PjJCF4VDJIDDBRHd8meVL
 VwQEHPhB9W6k4h3aRcWJNzHx9jpiqlVa8F/p0qTcBbu7QL4ihGsjudvGIy+MVPfdF9Ol
 H5JuM8Ho9Nzs6Ip6NsJzTFJiu9F/7wjeigjNhgQmVwMzpoEASwbRkt6Y5x083GqS+MRq
 AwdanokQuuBL6QCrtTJi5yv3fvVWpP84GWh4J2UEod2cN3gKpWKFStlR3s38BquBwKJ1
 jyRFQXduH3zyUaSsBNr7RCTowkdyoeIEECJrW63FXn0Phchc+k6twn1PAtqYVXfXwbIy
 r1NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+j8nUT2aGqkmbqDlWDxhmqIi3gqJBixQRXaaMqbBTTLVz4EMEJR++uIzOfayUZcE9xxfBSwz0tmDW@nongnu.org
X-Gm-Message-State: AOJu0Yzo1DRHb2zHvz9ELCsdDYn9qJGzz8SliuMHs0SeQ/DvBEUXqxXu
 Vcj4arzO/rt4dGY8DN3LcmADY/+SbDDlp/M/SGumDVZeofzOgE+Jdznl7qtgEGk=
X-Google-Smtp-Source: AGHT+IHIzipxfmwSPfZxM97+WFZEwa6R0w7t+9K+6gYUNkqckbpC0ixR15l5B9O3GNoKRhN05fLM+g==
X-Received: by 2002:a17:907:72d0:b0:a8b:5dcf:493e with SMTP id
 a640c23a62f3a-a8ffae04929mr267865666b.58.1726035178494; 
 Tue, 10 Sep 2024 23:12:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cefa24sm581411166b.178.2024.09.10.23.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 23:12:57 -0700 (PDT)
Message-ID: <2b1b2d3b-7991-464c-abc7-5de5cc330297@linaro.org>
Date: Wed, 11 Sep 2024 08:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/39] hw/gpio: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-28-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910221606.1817478-28-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/9/24 00:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/gpio/nrf51_gpio.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


