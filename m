Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CF0D735F3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGkk-0004rN-DY; Sat, 30 Nov 2024 01:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGkh-0004iF-JS
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:14:47 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGkf-0002GC-JP
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:14:47 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21290973bcbso24177855ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947284; x=1733552084;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5csVjrGoh28OAUAki4L3dqIWI/wSyCSHOlktOlqqTn0=;
 b=ZRR2R4s4lU9xHig3M4vO1oQMj1e3PNMRWQpz2tbXY/z0jeK38YYEs9xqUvf1U4bfLd
 XwkYZU/B6v3kIWzTP39eGQ2KbIbZKikdHpvcwQbEcs+sxZ+DL1nlYuOC6tyJjGUuG+W5
 wdwE4nEf8yph+Z4qH+ZvkRKQn+QuSFHBAJJVVg+LTZxsTIbOmIzt87h3GQTA2IlXu5cr
 6a+rTRY8b/0OBNzZaWri7PuG5DrbLkLnpPsRpQrbBLSvWt7l20UV9KMUBoaYLqa92CVl
 vDlbGndloycmBBw7NxqVW+cjB0S4BHugZ11UV+Pvd0kUGO/8LWtR17nqMpqzpwNH37VN
 i0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947284; x=1733552084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5csVjrGoh28OAUAki4L3dqIWI/wSyCSHOlktOlqqTn0=;
 b=pp3a2d2+bdJxvOFCApvJcabJ9HG7bjqZfGqrPASiCr+ifgI2uQNTIgdmygZZJgniYN
 pqG+pF6WdMF9a4Q2H4mQ5l7qexyibPb6WRLBM0xp4d8cuh7QBMgiIuslNJninFQunZXE
 YOEtiLfEQ9kcq2mMZIzMKbBrdJQVKH9EZa1tCmeDDTPjWjYAmBt8Aupfv6TiYnsrU49l
 DtX6v+5+LU8p9HCY6JpRy3eVIms/TzlMDu/mosVVtHb2F8I6gb37BrMicypa3usOAAsA
 Ixq2iNTcCf6hpohwqeJ7PvtXIRzpMHHyjhbr8JsUvQI4AUTdc/dckio0yJ/8/gm6ryce
 Rafw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuc2BROg7lEsG/VC82m/FNk1uCowo7LOOqYmEo1JbkOWXYNK6eZ7mEyY6HliTA8wr1WDU+/wZOcDbH@nongnu.org
X-Gm-Message-State: AOJu0YyxvG4EpS1KcCzKehpEtXXNsvaq44HfjfN+XhXQd66iR2tF41h5
 eykd/OqueejSwvB3Oe2D1I/95VCUX4EtsH6hAwr7biRMUZ3otq1oGFgvdIXo31E=
X-Gm-Gg: ASbGncvmEMqxFy+oMquUgE70OSmJ1pxfc2mdUgiB5DThBlDWBhX44Si32vztdDsB36M
 hUXTdetEgRCtxPMdUOAAqS/O3jBb2t0dkI9EAJVN6l2kKiP1y61CdDL07G8/UkO2Z6z/NqWL133
 iNmKsVbvqjLx1IUs8LCL5ocksJZLRorbC2yd/VYYvWqXvaeodSh82+cuuXi1R7QB/uBH5ob6JLa
 LnxvWg4fvhF5H4c68nb/Nl1Cn6+GDr8avtoxFbq2DgXwB/2b6KN8ADk0KBW+9Y=
X-Google-Smtp-Source: AGHT+IFum8fHMKzFU19YOFN8+uBJ5s+EfvYaWMtm4Yz5c/HPGPsVtBzudWtNiGpEBr6csMP5VKj6Kw==
X-Received: by 2002:a17:902:da91:b0:211:aa9e:b808 with SMTP id
 d9443c01a7336-215010854d6mr188611005ad.6.1732947284254; 
 Fri, 29 Nov 2024 22:14:44 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21539e88cefsm26903535ad.182.2024.11.29.22.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:14:43 -0800 (PST)
Message-ID: <446f2514-4ac5-4672-8be4-726379939b2e@daynix.com>
Date: Sat, 30 Nov 2024 15:14:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/15] hw: Add vmapple subdir
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-7-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-7-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/30 0:24, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> We will introduce a number of devices that are specific to the vmapple
> target machine. To keep them all tidily together, let's put them into
> a single target directory.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

