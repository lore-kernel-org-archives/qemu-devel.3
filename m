Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606CECFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmSg-0003QI-PN; Tue, 25 Nov 2025 01:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmSe-0003Ot-Ch
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:23:36 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmSb-0003PS-I1
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:23:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so26927745e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051812; x=1764656612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOOQl3kZW1bVC+fk7t2YWU1R6hWEB46Dmnal7magMFw=;
 b=QmKlvv7Q+Zu8djKPc5aBr4sGJ36pXkr4GUGOLbCwK20Xr07aGaUSNpKejYxOsko7i8
 jwAdMQKWjP677IKMVyJTBQBBwLKuOvtEDf/aIpBvmUfr9t+gK1WE6BXsdU0tU8bn49Mo
 h3Ja4tLNUQ37/yHEV2AI6hthUo1nL5khlNwrBXNFo7q9HOyo5nYC8kkkyE++04o7+5qj
 +jCsxBZ/3h6rg50tSs1Y3uwRaBZ0o+21o58RikD7MQ36N1YyLHMwbYnxDqT0GB0oea3j
 4Kw4oWV51hWGgfnp8hRPr7jLyPz+5cNKEStMD7u9ojOYZAjDfvto3j4z5wwXG87f/Q8g
 MUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051812; x=1764656612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOOQl3kZW1bVC+fk7t2YWU1R6hWEB46Dmnal7magMFw=;
 b=BsNe0H09loHyANHUOjNokOZ+uWbLqZ/ihcRge5TZivP78DqYgHnnLUxNmDKlsKwHof
 d5RlZ5kDJiJsjHmrDOLt1p8hC4mxlklE5oQlyb8xABcjnHkC5DGji/UAmrmvAPVZm85d
 IW266m+zHY4yFj/AM9dGS8qRPMxZb0cd6+zoNi6O/uTPXVPJIYN9kCyW5caDzS9B0TQ/
 l3j/RLZ43ICXp9DwwEDx/keEK1Wa3of8XklvrIx3cA3i2B11xfndOOzptCZWrLyPKP4o
 yIv/tH+uZYN3AUuoip7s3oZG46RPqVX0sQyfehvdbvZeNVnaEE9VKUsc7qkJGn/A5EQ3
 A+qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUys/wVxGJpSYL/BCbq0xKfkcXLQ8CM3QFgmLY07FoifzdHO9lrbFl3tDVGPIeyoQJtCsHkthZ+vNPK@nongnu.org
X-Gm-Message-State: AOJu0YzjNIM2vTugKQi2abYGiayD4j9LiK0x8h2mUsaOL6ZKZkUIuCZD
 BL3FWThxWOteF/CgNLmcWXk6eHdl9JGgOfk8xz814URYh8xNbdm4Zj6fFs1aWmCwOSA=
X-Gm-Gg: ASbGncuBBJ37E/EvabGZaO5bRq3VWbXfKhzlUW1krx2qR8GZ/8fbA8s1TfABObGYY9l
 obpJIQ8Xu4n0oDdQHqiD+VFrjPQ63kWcFSk/ibBTRKjXl1EHkw/r+NKvINq/h4Geb9eeZcapcbA
 XWt2/AeebAtvbxJMElc/um4dNP9KzQ75e6MhWUVIjPf8sLqlsNoZXzUE8JpnUDjV5IktYjknPCo
 80cktHpVclN4TW4+RnP5ivvpHFKEAB4MjrKYzamAMXACgBa1EUlrbU/SF5ahDzyX7SwYEiRP+ps
 SS1sl3qH5vtnPpq6a/FQZLkNz/ChI5V0HHlC8TlWx99BP8zMXHjtpq5D1oWoPNpRHr6RG9nvCAI
 MVJtaQDE0tiDq7FzTFQesq6nKj/EKAhE10+go2tmHftgPgDZHYX9+O/kPach3vVp4ldbxN0WJyi
 jbcsq5G83gURyHk0Z8C2SGyLoMvV4VN3BQFR4KV5P7L/2nTSfpPMXXHZVWjQ5HAyIY
X-Google-Smtp-Source: AGHT+IGLa5fRK9K5L3FkUn0xfaMF4zkOQClpsNtdNtMutakIaGVpTMJc0y08tQVlCwv9gBeMm+157Q==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id
 5b1f17b1804b1-477c1142268mr112956985e9.20.1764051811939; 
 Mon, 24 Nov 2025 22:23:31 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf226c2asm231059685e9.10.2025.11.24.22.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:23:31 -0800 (PST)
Message-ID: <541f756c-0fde-488b-b386-814fb276ebae@linaro.org>
Date: Tue, 25 Nov 2025 07:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] error: Use error_setg_errno() for simplicity and
 consistency
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-14-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-14-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 21/11/25 13:14, Markus Armbruster wrote:
> Use error_setg_errno() instead of passing the value of strerror() or
> g_strerror() to error_setg().
> 
> The separator between the error message proper and the value of
> strerror() changes from " : ", "", " - ", "- " to ": " in places.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/spdm-socket.c      |  4 ++--
>   backends/tpm/tpm_emulator.c | 13 +++++--------
>   hw/9pfs/9p.c                |  3 +--
>   hw/acpi/core.c              |  3 +--
>   hw/intc/openpic_kvm.c       |  3 +--
>   hw/intc/xics_kvm.c          |  5 +++--
>   hw/remote/vfio-user-obj.c   | 18 +++++++++---------
>   hw/sensor/emc141x.c         |  4 ++--
>   hw/sensor/tmp421.c          |  4 ++--
>   hw/smbios/smbios.c          |  4 ++--
>   hw/virtio/vdpa-dev.c        |  4 ++--
>   migration/postcopy-ram.c    | 10 +++++-----
>   net/slirp.c                 |  5 +++--
>   qga/commands-posix-ssh.c    | 23 +++++++++++++----------
>   system/vl.c                 |  2 +-
>   target/ppc/kvm.c            |  5 ++---
>   16 files changed, 54 insertions(+), 56 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


