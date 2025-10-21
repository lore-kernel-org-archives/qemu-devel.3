Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3007CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJ1E-0005T6-2r; Tue, 21 Oct 2025 16:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJ10-0005KU-Im
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:31:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJ0w-00063M-5c
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:31:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so57587615e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761078683; x=1761683483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e46Xpd7tLYIKXwBbt7lbuURVIUXwhDVyJ1/luhq2CqY=;
 b=iD/H9g+cT/nQ66n994jErV6LFlKhc3cwqoXlwyk47j7BaL/Awg3RgzFA8Fk2sscwtz
 4uv4TpgrHxFhU3mDnHqULFtfW2a5Y0Zivzkbma7p+O1d111mDlrxT6NAUZGZ0101E98w
 Vwn0o60u4AqUCTPBxKx3tlbnbnHc05B1aOlyCjS+Vhd2r98vO+xMKgQeP2n7JdtHDT4M
 WHSxCWrNxrxbJ2sRIC9lLm0ppc4nSjPoOaj22PXsNtiJ+3MOmIgmRtyOmURawTk1Vwte
 Y+cfmeJsK4ACWLQSLrx7qX9sIWo++NXaZtSaBMaICF7BqGvdFrx7fnCx4xuoDLJRpfa/
 rZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078683; x=1761683483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e46Xpd7tLYIKXwBbt7lbuURVIUXwhDVyJ1/luhq2CqY=;
 b=hPoLqQQqExMSGcfV9hj4UNjdvUgcEVxQKW9KO6S/i9uNNvwaM9tZF3soKYKUvdLOU2
 e7BP+2zsM8VSnSNkBCWELnpjuDJ9AAiOe4F7acsF9eDhvhFwWGU7JBPoDhm6D3Ky63Wu
 AP4UDQlR+f9zcQrvd6IgTOUjUDhuHUL51E7B/Cmq1lbTJlnX++Gg8VX8bwI90oKqSTDv
 xB3+Cy/ef2AnF/n93SKTykCKpuSn6vUkXkkk9/flTsbIUFTj0diwsfGCJq6YoLjVEuyE
 Y7LEg9BB9B37gCKaJ/lH6HNq8hWhh/nnsU0fyQZMBXfjzmGV5d6YKin42AIa5nz4lVKg
 aCLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhORciwxlfMoy5jLNdQWACABc2Gcn3UMZ8RBtOpsYrpcPzmK/TfdnQfnfuL6EvvjuMcifL1ycwyjuM@nongnu.org
X-Gm-Message-State: AOJu0Ywuzvhx4kKq+o58OOgKEvmBvqnH51WviOe3z0otHM/ADyBSHGeY
 j/+wPg14J5811g4NoHTBF9BFWjYPW6jQsPerwTbKeTCxqxDE5XO78Vm5nUfkD2uuUhU=
X-Gm-Gg: ASbGnctbLiq+kA/MsTMzkRCYMso37f56xBFe+DwQE7hxyy2+nEuse3bxwjGg+bnGsMn
 2Hr8Jl4qV1cQSvmQUHZAiEZTaKoK+YG2aPmjHkBiQ7mZRnHyRqbJ44swk6epPeiCFX82AVQ4whY
 GMSe878UDf3CdkqIp7k8G6BC/uJf5ShBU6nf9+TB+CJkwzUhw/+Nc4jnGZslGu4hbBSm5t7j83V
 QWUGrFKI4Auhg+jfuW6kAWI70prm/figoTVo8wFgbQZNY1sI1T4jahB8z2fAw+fzB++vGu5DZEl
 +Dc8plr+NQehAvv1E6iAdD9uAJXJYHHhiz7lhKz9LstqYPMqpFRNPoUWmpCQBvhEXFc2z0e1RIw
 f2PIBSUrGiGoiW6XuEhMuXXPwyTvfb/vIZLPRjRUJSWESGtDoCrH31NgAkjDem9tp2D3L04OEKq
 zp17RM+B92wiL6Je4Lp0ZxP6KviZ5txTWDi6ABazCImyZff8yitHUndQ==
X-Google-Smtp-Source: AGHT+IH3MFgzooHeifTv6goalvSCOCkji2kNHftd9bPXF0cgSvPl9wwmDkwJqJSwTixMtYZTPoNSRQ==
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id
 5b1f17b1804b1-471178b125amr134414325e9.15.1761078683529; 
 Tue, 21 Oct 2025 13:31:23 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c14a26sm23142735e9.4.2025.10.21.13.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:31:22 -0700 (PDT)
Message-ID: <e2b73955-13b6-4987-a24c-1b8998597d07@linaro.org>
Date: Tue, 21 Oct 2025 22:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] hw/intc/apic: Pass APICCommonState to
 apic_register_{read, write}
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <20251019210303.104718-10-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Bernhard,

On 19/10/25 23:03, Bernhard Beschow wrote:
> As per the previous patch, the APIC instance is already available in
> apic_msr_{read,write}, so it can be passed along. It turns out that
> the call to cpu_get_current_apic() is only required in
> apic_mem_{read,write}, so it has been moved there. Longer term,
> cpu_get_current_apic() could be removed entirely if
> apic_mem_{read,write} is tied to a CPU's local address space.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/intc/apic.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)


> @@ -1054,12 +1046,17 @@ static int apic_register_write(int index, uint64_t val)
>   static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
>                              unsigned size)
>   {
> +    APICCommonState *s = cpu_get_current_apic();
>       int index = (addr >> 4) & 0xff;
>   
>       if (size < 4) {
>           return;
>       }
>   
> +    if (!s) {
> +        return;
> +    }

This is not the correct place to return...

>       if (addr > 0xfff || !index) {
>           /*
>            * MSI and MMIO APIC are at the same memory location,

... because of this comment. See the (squashed) fix below.

> @@ -1073,7 +1070,7 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
>           return;
>       }
>   
> -    apic_register_write(index, val);
> +    apic_register_write(s, index, val);
>   }

-- >8 --
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 077ef18686b..aad253af158 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -1046,30 +1046,30 @@ static int apic_register_write(APICCommonState 
*s, int index, uint64_t val)
  static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
                             unsigned size)
  {
      APICCommonState *s = cpu_get_current_apic();
      int index = (addr >> 4) & 0xff;

      if (size < 4) {
          return;
      }

-    if (!s) {
-        return;
-    }
-
      if (addr > 0xfff || !index) {
          /*
           * MSI and MMIO APIC are at the same memory location,
           * but actually not on the global bus: MSI is on PCI bus
           * APIC is connected directly to the CPU.
           * Mapping them on the global bus happens to work because
           * MSI registers are reserved in APIC MMIO and vice versa.
           */
          MSIMessage msi = { .address = addr, .data = val };
          apic_send_msi(&msi);
          return;
      }

+    if (!s) {
+        return;
+    }
+
      apic_register_write(s, index, val);
  }

---

