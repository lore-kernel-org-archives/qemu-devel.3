Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83570C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjTz-0004of-EW; Thu, 12 Jun 2025 11:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjTk-0004k2-Hv
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:04:35 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjTd-0004Tp-GL
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:04:29 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so1026369276.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749740662; x=1750345462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mwRohgyatrsnok8RQFXYdLlHld9AUTUpziIQUj48/Fk=;
 b=MjcH4m1QS4ptoUEirF/4NrtrJc+FBafEouqOXm6S4RBqq1h87ieosj7HFM0rqba5Jw
 a2R4mMMpaF0RgTRUNWzV3zqhTQPL3pyj1bDZNSYstDNUhLPgFzgLiAbd8SHpOfRdiL+f
 Ubtzz8PkWRiYnYqOc0ZvqE/xNjJCJmru7TgESW4NHN+vG3GrfBs3z0bUx3AqzFjSEDj2
 uEc7Lw+mATaX9OrHKlbxEV1zQqHVeVU/Un2y8We4YibmWRo9Kh6IDBEsHkSnV90NLgYy
 jlBclFctfEq8ggDXoMlU2h+BaTNcRSjFhnfOaRNqmsYJnA1lZZE73XVQsRwRkIBwOYxa
 i3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749740662; x=1750345462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwRohgyatrsnok8RQFXYdLlHld9AUTUpziIQUj48/Fk=;
 b=SBmJiqKQSOsrHgNfIaWjMyhwExF66qXH4spSE0Dh0+GREfzg1fInjFQGIvyDknKc5v
 a2TCj5htYNK8aZYfcZZzP5nX+UfHALZELQAlXnKWwcvIeBjNdGU23i9b17AEQFIVuUqx
 VODk3sbjBNTXyS3FHWeX4F/TUKtRx6wmRz1OyrnfMbxH5ts5WyuZyOQRkG0Rge7jBXDw
 X58WetURf7H4LJ+IAgQ4RLu9uEJ+dKgF7yuf5XJpxMaXjtbJcz2RB2JmHILBqJGtYYNn
 MKOJezmBWWe2FerKuaFz/6VK8eOMrRlNl+g161aGmrUhvZoNCJem61Z68L7JfSwSDExv
 Lvqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdYrXMB+2gQ9KnEXWn5nM6ksBOdFULCT9bIaScySEdglu1EpQVYKk6sn+PaRa+perqWpKgSKx7+t1b@nongnu.org
X-Gm-Message-State: AOJu0YzYw6BQLNPPEQ9yyNrMWJ6dGGAGn91hgwzJsOypKSdcu0yj1x/A
 sO7KXW/ixBXZV1ebCxwxkrhVRrDIznQioooSoHzcIVqRG3oCqoHgQDDgia+01kN2svwWDg11MS5
 fThAfQz6XRvrBgSWsUdNVROBnEumemAknxSp1lwWyDQ==
X-Gm-Gg: ASbGncsuLs6MV+fHESzOTqTF7j8Ml9gR848IIEX2vlGNs4wFghcvqNBJ9E282bGcuDL
 9n/dgJGQ1h/6B9yvvJRaeUNk0CxYhY22cQC5UlYQdeVsfm1UKIzXVc+GULRqkTIgVb8wDDyQ3gJ
 2K7KVbDDc0FliIhbnEof+dF7IDUVJ1G2l5DCJh7nZCJKz/
X-Google-Smtp-Source: AGHT+IGkwf3AJrycbkaLsXCktxf09YCtxZ4zQIpiVu3XRTDHJMzFJzu0b0P9/VzPi89aVoUmCtZ/VVXUpqdEnylPPMc=
X-Received: by 2002:a05:690c:498d:b0:710:f46d:cee0 with SMTP id
 00721157ae682-7114edcb04fmr56567777b3.33.1749740662363; Thu, 12 Jun 2025
 08:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-3-cohuck@redhat.com>
In-Reply-To: <20250515153907.151174-3-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:04:09 +0100
X-Gm-Features: AX0GCFtWVVUEsGciOpuhQYdpTNAk5ugyqKk3hjsV_bBetoONUXe_HXNhehSuotE
Message-ID: <CAFEAcA8y_wwZPoqkyPrNscRNTEwiOQm5Or9C=aiSNMGcZmq8CQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/14] arm/cpu: Store aa64isar0/aa64zfr0 into the
 idregs arrays
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 15 May 2025 at 16:39, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> Also add kvm accessors for storing host features into idregs.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>


>      if (!cpu->has_neon && !cpu->has_vfp) {
> -        uint64_t t;
> +        unit64_t t;

This doesn't compile :-)

-- PMM

