Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31748C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 09:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFVz5-0003mB-32; Fri, 07 Jun 2024 05:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sFVz4-0003lv-5a
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 05:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sFVz2-0008EL-OP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 05:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717752843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pD2j6bkZfl7M5JSD4u7KJ2S1orzSiMYXVvW9iDcCYwc=;
 b=gdGaZ0z2qjZdEesQFmYvwwE+MyPlvUW/553d6GHBpUIJCsuXp52hIl9CUrsud74P8leCxt
 UmmVQ5i80lMq7tCNk7tth40Bd14nIlSJ9mne58GSR+QwAjsSfSXQWm5UAJk7Jgx0/fEDG5
 g90nWNFBm9kiZnfX8FDpi2nofvov42M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-0yV3Ngl7MFG96hPAabIjOw-1; Fri, 07 Jun 2024 05:34:00 -0400
X-MC-Unique: 0yV3Ngl7MFG96hPAabIjOw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6e37310ebaso13021466b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 02:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717752839; x=1718357639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD2j6bkZfl7M5JSD4u7KJ2S1orzSiMYXVvW9iDcCYwc=;
 b=um5MEliUtQuKFAISQXJGCRg4QpM5RLC6aGtcOSEFDFGO/Z2KPQhcAPAgw1qLUFLyQc
 Pg2fLQvJwW3MMwJcVUlTAnRopLJdi0oUeIKmk0JBE4tY75nk8P+4H+R7zYA2gEUwg23Q
 l6oXH+Ltx9jvUAM7pnmzOrEVUm4FEup/02zqgshhex79ONedNXidlXjDziTwZisy42Fn
 6afBKOxp3SfFo+Mi7DHB9CjxVGKZJKC1MtR8/0+VUvgIAVG2peJ8hyri6f+ExIyxbyaL
 wuH3brhC0Kx7NBzcAIc2rhX0pBDOh7uowN25I8aQzUapvI3W+g/rj92igc3mwuUNZYY/
 kuSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY1LLFP4DhEKar92J1fXgqA0JGzbaiUjTQH14oCcY58yTle3zeoAIs/2/I1Yz5og5h7aTIrMAyqa18qIfjOkjDwCydoFk=
X-Gm-Message-State: AOJu0YwXPFOjrFM50f30l6I/X3BK+AmLA/4INa9YLk0tBwvfJgOqfwru
 XRRiGXYilK24azbgzsUAXegaWme3ZrTUgSGZ/PXoI2LeHMZrLTomOjBTvjpQ72rw7X9o/xEgfjT
 +U+76cTQS9QVy1JT5WIzXMDVvp3k7Z1+qDI1jz2krqlG9eoZzmZrn
X-Received: by 2002:a17:906:612:b0:a68:cb91:f98d with SMTP id
 a640c23a62f3a-a6cd76a937bmr138553866b.37.1717752839341; 
 Fri, 07 Jun 2024 02:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHErldoNUCENUMY9jnxXOxvynrj4pFxwPXony600c/3aYqGw9OlHQUK3apGRq6Ul7iL8Ncxmw==
X-Received: by 2002:a17:906:612:b0:a68:cb91:f98d with SMTP id
 a640c23a62f3a-a6cd76a937bmr138551766b.37.1717752838857; 
 Fri, 07 Jun 2024 02:33:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80728d03sm219865366b.208.2024.06.07.02.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 02:33:58 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:33:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH v2 1/3] tests/acpi: pc: allow DSDT acpi table changes
Message-ID: <20240607053322-mutt-send-email-mst@kernel.org>
References: <20240607085903.1349513-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607085903.1349513-1-ribalda@chromium.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 07, 2024 at 08:58:56AM +0000, Ricardo Ribalda wrote:
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>


Thanks for working on this.
Pls include a cover letter with a patchset in the future.
That should include a changelog, too.

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..b2c2c10cbc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/pc/DSDT",
> -- 
> 2.45.2.505.gda0bf45e8d-goog


