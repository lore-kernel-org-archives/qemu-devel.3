Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA1ECFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmUL-0005DM-GB; Tue, 25 Nov 2025 01:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmUH-0004xE-KL
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:25:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmUD-0003nh-TK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:25:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so28869895e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051909; x=1764656709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kq1R/KnIl0tjtGNpVBFK4blvRpvREmYvjs4Wzx+ZU8A=;
 b=r7Fjv1x1QIUZ27TC+N6rW86RME/T4eVzmDQICnymq/Nc7OfzM1yfSQaajjPsd597dS
 YLmm+aRBkl5iU/7MWcKUAFwwNpHUhLizv2t6WqqowSyBLHrpr55CtciZhHMUwIyL/HZM
 7nvitYK8wn0HVSB6D9TpRyGsfChO7/lND2E/Q0mMoZFKXY8w+HoVeKt2V5zMt1i+oIt3
 CEDZn3PJmIf1T3rI42KagWL9d/1G36ifD0QZXzA5WP/N1Zbepd/eS+hgnJLgEu4U3RQv
 qe9I/pQZB8NlcdBbpkwCzd0WvXTj/XKTBuoDd03uIlpnWA6qEEEK7xQgL+oWLq9lWui9
 7kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051909; x=1764656709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kq1R/KnIl0tjtGNpVBFK4blvRpvREmYvjs4Wzx+ZU8A=;
 b=bykT0bJiUh1E5dS5ACP4nCwOdmEkcS/BSIq4WJuAUQ80IAgV53a1r/ldaoCypNk0sJ
 nlsfIkclu1CSM0CvDPCsr/tzgt4NrWWEdtYc3Q0Lbc3aY/YJ/ddNX7T8uu+Eye0TLAyl
 GVl4wJfH+ETMLk3qFMr2O6ZxH2rSrZh26waCZis2LRxdyEYWnChXKdlZfMdKMnJOf5nx
 cgzXcJY7ykVr1mWNOkDCY+SwkMtwiKnFjP+RTMKvaQAhuupzDUKIq2n8tgLj9tfx3VC2
 E5tsKNnDFpHb1RJ0nrHL83GYp1IxM2nHDeTSS2tlFEXmqT+X0b8qvEDUszBUzJFBk3KW
 q+Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSBwAbnIl2Wkk8+fZzN2HVmOeYtlKUsRlNjqZOTfVnq7j7ZAZ66peDyEny3chYnraN0m2QX+BG9GJG@nongnu.org
X-Gm-Message-State: AOJu0YxN2QUeAxaUkQDlJnho9YlPUDlEFCgQKq02hSkYRNtVcCndJbpL
 sGMV/8lnKXf3TEtmrVYhT2CG+31XSTKFHfMTiw4KazQyxq3C/pLzvwpozEQzfWDbSOs=
X-Gm-Gg: ASbGnctB3rXoURmfaSLSaw1cBP9v6xNIRkX+zomgFa8LdYiQylgZ+44AOF2rJje5R0F
 3+YvNROa/8q8RfBe/dNs0stHPkcCeyS2ial08oi/faJ1KRt1NT5z1XiW+7409uj2bR0tmtjMyUF
 18fEv/w+qzthBa37Sr1gKPafXcr4T/Y6lsILT6xkt6ZEZyQG6q0be4iCpL/CEH3mdmp0ovNBlD2
 zihh+BoO0zl+6mUppU/rMBtWMdiFvPhRH5xn8BaJg6uNkanolCytoLzVT4OMZ180dxUTmMq4o79
 Cr3UYT75cpamlQo3vySz9f3JE7ZA/sZtCj/zkcYWDsdc33LGxgIWu3nwX/uGBshfTjDElaizdxM
 TBJAppv1yN9WYZqmwzKmeW82bYfGEF1Mj8N1RLDSLLUpT9LZaInqZQxpQhZhkTve4m8tlhwIWho
 OG32VXNV+gmq82Xy4kifGDBuKy1dojm73i9rXEEDK7zEqo4kpqJc4znw==
X-Google-Smtp-Source: AGHT+IFprm3vCDsbWVJfgbV9xKa8iHTCEmXL664XoxSCOsyM7eQ2uIrryW9dfBTvUiv91/I4gz9/gg==
X-Received: by 2002:a05:600c:4685:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-47904acaf28mr11379725e9.5.1764051908756; 
 Mon, 24 Nov 2025 22:25:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm32968445f8f.16.2025.11.24.22.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:25:08 -0800 (PST)
Message-ID: <54be619f-1de6-47c6-993c-246fa6252596@linaro.org>
Date: Tue, 25 Nov 2025 07:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] block/file-win32: Improve an error message
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
 <20251121121438.1249498-16-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-16-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 21/11/25 13:14, Markus Armbruster wrote:
> Two out of three calls of CreateFile() use error_setg_win32() to
> report errors.  The third uses error_setg_errno(), mapping
> ERROR_ACCESS_DENIED to EACCES, and everything else to EINVAL, throwing
> away detail.  Switch it to error_setg_win32().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/file-win32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


