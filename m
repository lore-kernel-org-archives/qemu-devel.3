Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE962CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAn3U-0004N8-6u; Mon, 20 Oct 2025 06:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAn3R-0004JA-JI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAn3O-000771-QC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760955829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uoKcw8pyZA9ViiX0QlnZly8imxNfH8hl7G+ZuLX0Wvc=;
 b=PpMpsOkn9MRG+UYK9zknYtULypIJc/BIBE2n+LCjswTwdpDUzaKkUebUDGQyqBwgVoTf/K
 Q6m2mgus/5FlCI2ZZKRgdJzYyepwYLuyyBqBYSNb2x/ai11c5opjtNH79mxWArqbTEpBqe
 Pbeqc0i1/eAkEi8Xae3DFc/BKzmRk0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-WPJbjwyLPCC_4V3fAMqlCg-1; Mon, 20 Oct 2025 06:23:47 -0400
X-MC-Unique: WPJbjwyLPCC_4V3fAMqlCg-1
X-Mimecast-MFC-AGG-ID: WPJbjwyLPCC_4V3fAMqlCg_1760955826
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47113dcc15dso30917915e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760955826; x=1761560626;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoKcw8pyZA9ViiX0QlnZly8imxNfH8hl7G+ZuLX0Wvc=;
 b=oO6qa0BC+8GqHMplAoWeHJNMu5wftFygjID4t1KcjphFsvHx5D5dWyqSOpn+7O+n9O
 PxPbYhOMTGNo1QheqvvcCg097wSzZXzKfaKoCsj8QnQ03J1AOx6OsZ9Ok0SfAl+fGJMJ
 8wCdkkoJMYhX8kpasm/zpSlpDiJxHWFW+EY/qfYeKRJLAnhQe40B0ZmcUQY3GnP2myMm
 7UZGyqVggZIj0YfdwS2Ag4ENzlmHHtDYi3+gObxBuUL1H2UgBzqCk+nsk3D4Kv0B9oGY
 Ai1gU1FqHyq99dR/kpKgvl9QYt+LHIgLKUxTpOXc/T3HELx4iKyTfin0fRo2gaGa/SJ/
 hljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa5S6lvoesmA5T5vXJPTfFfwDLwU3kp+rcuuRTWd9vanL7ptayGr1lEUHUEjYgN/NrYreMca39sq0c@nongnu.org
X-Gm-Message-State: AOJu0Yw11TH00RGPHVDJAIj8b9sAVPK9mYfXSKwDeLTguGD7BOIYy5ON
 FGYh7WCs026FEVbJ418YQ22Bt8EiZJZWPjqtAHS5wxX1LOFwmfYOc7INysOLZGnBs7bm/h5amqI
 YERP5XlGPIiIcJTCI5y1tn03PHGPBd8igMBlxSGPBb0ozmHT+518mw5bx
X-Gm-Gg: ASbGnctUV+cxCTFOcSBt4WwB2XJT3qESNodT4/CQZ0VqKOfB8VrQOdEPRKuuEpv4dkh
 CUKlcI10d3R4b2Lc3SyCJmv0NsgrgtQxj/jS5N8cha2qgLllCpQVw0KdNvG1m9/sJC4Pvagplnx
 dYdSid+YZRRxue8giBe/OQ1bIfZ5EzCKLYfDg81cZG8a9DIfFtD+2EVsL8otcii5gGHe3QrR42t
 HwIY1cHsA1/34tZOkaWqcTa430fPwErrzBHZDtblsvDWAwritXIbnbu47poZ+t9ipiz6lfXx+ti
 5AuK7uEUPY//I0oNzWRLhuJLM8hSMeDiiwbN7ZGEcm7e8NhWJDRENRY5kPNrYOZy0z/HmpLFkj0
 PeJNeSkMegguZmrXsqxjsmdb4Gk4sixbSeUlHtNrg
X-Received: by 2002:a05:600c:458b:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-471178774bfmr85774175e9.11.1760955826412; 
 Mon, 20 Oct 2025 03:23:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgwtvv4Pz5hmDP9CWlNAT87b5OVKS7GvlnugJHNO8y0b6JwzK54ROJM6N1h18ZZ1B6IpFV7A==
X-Received: by 2002:a05:600c:458b:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-471178774bfmr85773985e9.11.1760955826026; 
 Mon, 20 Oct 2025 03:23:46 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520d753sm138146485e9.13.2025.10.20.03.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 03:23:45 -0700 (PDT)
Message-ID: <93dc7be6-cee8-430b-b5b5-96bff9a0b8cc@redhat.com>
Date: Mon, 20 Oct 2025 12:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/s390x/ccw: Remove SCLPDevice::increment_size
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20251020094903.72182-1-philmd@linaro.org>
 <20251020094903.72182-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020094903.72182-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/2025 11.49, Philippe Mathieu-Daudé wrote:
> The SCLPDevice::increment_size field was only used by the
> s390-ccw-virtio-4.2 machine, which got removed. Remove it
> as now unused, along with the sclp_memory_init() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/s390x/sclp.h |  5 +----
>   hw/s390x/sclp.c         | 34 +++-------------------------------
>   2 files changed, 4 insertions(+), 35 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


