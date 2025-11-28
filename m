Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D878CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 14:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOz8F-0000XJ-AU; Fri, 28 Nov 2025 09:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOz8D-0000WY-Lb
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOz8B-0005Yq-Th
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpsArHMDWhQnZ48+h1svHXcQNA5FM0Gqizl/c11YZ1g=;
 b=cgqBOcXAnjDLkiS6+V9mXOVojndszRpRtXBR1jaSxAhrL1gzIqh6a1jaNRcOHGIii4yOok
 ouH9m8kiu2882JVe0IJDdJHEoJertiEEq4VlNtn5CtSjYgBHvLMTpHCt5eC2CWfNrzd9RN
 tik5a930r0aWvHI3mLvOxHUepdhXjuA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-fR_RX_yxNUWBPeYMs7znuw-1; Fri, 28 Nov 2025 09:07:24 -0500
X-MC-Unique: fR_RX_yxNUWBPeYMs7znuw-1
X-Mimecast-MFC-AGG-ID: fR_RX_yxNUWBPeYMs7znuw_1764338843
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so21014865e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764338843; x=1764943643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpsArHMDWhQnZ48+h1svHXcQNA5FM0Gqizl/c11YZ1g=;
 b=jBF0DuNzf6yqY7chbbQoivBNOU9hUQgvc8ixhaNkkv0MrshFxrWvyW+mmqwSw9kgZL
 d4VYvia+EUDF0fNyGyzC5OJaV87hI1FnXZcN4a6SeJMwFgM3IPmCGv4eGi02QC5Wqlp5
 Na50987eJssmMH7A9BAs7452r4hcn2G/HCmjQm6WzQyX8cIkCNVlj+r6HDEFvxjOMfSu
 7xxYS/CwMZT+0bvdt7iTWByRJT2yu53GESocVd5pXHIAO/MxMIL7NrxMmKjPGKTfB4/j
 /4W/B7+CmHoxx7KunJ6ZrEiIGPqamcIBugry1AHf+ckrjp3iaVxUKlKSu7e6UZ1cs1S+
 L86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338843; x=1764943643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DpsArHMDWhQnZ48+h1svHXcQNA5FM0Gqizl/c11YZ1g=;
 b=LoWTYiR+VumnWX+G/CX7JleAKhq5t2SpPanAC6UjjZsKe9COyduLgSHaSnXHGiBppY
 oYTWxf5xfypaH4I3bG5rITmZ0H22n1LSg32pnRaVsDvVNRg+oRkSjR6HveTiQ7hIRWeZ
 s1nF3nBbKDpQnQU/gvNA4kbMYRKPz4RZWuecnDXgP0AdClSEfURv9wm4Z+CmMcgCfnht
 u/lwy9L5YT4oG0vg6C7UafjsxV6pvaqfqqy3cJ53OZfvQH0u97w27+dJRFzYwWBFOoff
 xbx9+TWVp3ZYttCbtKP99zBlzFCBaW65YnQFkmDLVhH6sNbsVjI/mYM9XMwuQIiUQ4Wi
 W7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmw31XvdFC3ZhVLaBJCS3zqcCCFpYZWJF+i3mSw10USflgaDVqYDkL5722VYOeJeqcIHldktbarvjD@nongnu.org
X-Gm-Message-State: AOJu0YzH+peEg9lVRywcOUS6Ur+0FR8E5mBNxEj1i/taN6tqLM5hfUEI
 RQ9J3NBiHWkrr5tB1lNwe8wd6BYWbSBibhASO3436fHzjyR6CyCrrlctsu2G10E0DBjt+/5ktBQ
 vcBJNuzkuO26erU2/dSDhyaWFTNB5ZAqza7oXLpkIKzqUudrRzVW0AisP
X-Gm-Gg: ASbGnctNx7M0qNOBNxhj37dOxM7S8fXnzvY3aTZ9uoY/g02sr/Fa2v4G20J5tqiE03d
 8hEdMfflHR/2NaaQlpSh6BmMcfrw4k2tafNg79VbbnlLbFjlRRt364/45ouJy04G6Ks8YFXWutt
 isLaq6K7hpQv8pC+Eb0hZ1Z3haadMwzZcxQrhTSpcwZk+3uDtmz3opZZ8LisnKZqcAxNWgFEi/U
 mfJsDYtwU7MrRtIAFlKs+8lY8a9x7+A6sm9SN0H/m3ARajhC9w+uk1c+RFhPZPTkPDY1NeNxfaM
 sBJQeW4ccVSubz+ogzVvdTPfDS9c1LbaDzQrdoFTM5uWjzOz7SL9aWWJKTVW8KX/lIQ1Hg==
X-Received: by 2002:a05:6000:2891:b0:429:9323:2bec with SMTP id
 ffacd0b85a97d-42e0f356945mr17567438f8f.40.1764338843297; 
 Fri, 28 Nov 2025 06:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPCNKph31y97kHrbit085OznGbfGctx9/3cy2eR7oAnrTdSwNGrdNJnygUa71CNzADfiAccA==
X-Received: by 2002:a05:6000:2891:b0:429:9323:2bec with SMTP id
 ffacd0b85a97d-42e0f356945mr17567377f8f.40.1764338842774; 
 Fri, 28 Nov 2025 06:07:22 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca7880asm10089337f8f.31.2025.11.28.06.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:07:22 -0800 (PST)
Date: Fri, 28 Nov 2025 15:07:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 3/5] target/arm/kvm: Exit on error from
 acpi_ghes_memory_errors()
Message-ID: <20251128150721.390604e9@imammedo>
In-Reply-To: <20251127004435.2098335-4-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-4-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 27 Nov 2025 10:44:33 +1000
Gavin Shan <gshan@redhat.com> wrote:

> A core dump is no sense as there isn't programming bugs related to
> errors from acpi_ghes_memory_errors().
> 
> Exit instead of abort when the function returns errors, and the
> excessive error message is also dropped.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  target/arm/kvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..acda0b3fb4 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2460,8 +2460,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>                                               paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
> -                    error_report("failed to record the error");

so with message gone, user will just see qemu silently exit?

> -                    abort();
> +                    exit(1);
>                  }
>              }
>              return;


