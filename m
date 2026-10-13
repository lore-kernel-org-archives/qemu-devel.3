Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0ABCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGett-0008T5-S8; Tue, 13 Oct 2026 11:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGets-0008Sd-8t
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:58:48 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGetq-0007Po-NJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:58:48 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ae8607e8afso21157627b3.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907125; cv=none;
 d=google.com; s=arc-20260327;
 b=lNdoyr7YxPgAvz12W9SLaZ5WZ1/RJxb8yT8e54fTbP8J6KG1MA1wusV2ZtmUn8sQfV
 1zqtUrSqXH0LkuZq8NNYnbZdEFoOpzNXv8I0zJ5EnP8B13jKqtClwRY7lYo0Wa2LQjqW
 e25c/l7e+NjlGTqf1JgRdT6JPFQ3H50hsqEqqnk+rRQMeHCenFEEsHu/PFCX4vTe0lMy
 wTG/WXIOmseYIOxxp95vNAq1QkKlAOO/v0/v0SpPmFxNJzX8UdiyinunCjQLK2/xfAcT
 hXGUISxucXIIn07OgKVSzfQPoR5NOsQnQw7t8V2JU+DGoPZjvzYARtR9eIC+rzBPNBVN
 ICuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DZuhEJteCjiBcxYMsQ5/Kb0n1Eh3plqb2K4/0ypuhTg=;
 fh=OvlSvN//PIBfcDcUSBrzpBdeUtc9v87YgEVZitwAHos=;
 b=MjGG4BmnQCrlXY4SHUysLrvNEcsxUw7ci3hnWO1Gn528qIuVbaELMh4U/cYx4vX/Qe
 1Dw2QwSIgJLtuAu43a0OQm67POVMQZgmEFAKwWH3uA8N0HMqAdDf9aZfXZ6z4v35iiw0
 jTV8uDmUxflc2vKeEBiTrw56ZmFis3ZHt+aJwPPmqYf932qEQ9sB0/JGC5UBMbXj9o7E
 66y/424oU9JnNbfBv0UdaiT43rlk7aawLbqpwIMqu2Y5MQmgBYBd0Kavu5nv1FYbjFIz
 XDFhvxCVO5UTlqcUyPAFkBO6TNfZ3+UpN87V4hc7yZJnGAc8+CHGpseouSUlxomsNRts
 2hzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907125; x=1792511925; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DZuhEJteCjiBcxYMsQ5/Kb0n1Eh3plqb2K4/0ypuhTg=;
 b=rkd5g3f5KwYTB/6Vfrz8fEqZwjHVz4YIgCbWv5Q8k3Kf567Idy8762BWpt0yux5jti
 J8ICD4Ju27i5cUJZA9//pG4dGQyHmkum/2akyyJACFWVZQzNQkeN0eSnhqyCw3FEOR3V
 a0jvIPAStiF9vnhVd4yiAesUM1tFb0CAUvICHGjo/NMN7STEc7mFdaCSz8g/57EduzSA
 mnovkMm8S/T30w9ncW1auhjtn8Lh2GXmR3ycXYcmxYqpEiowSEumrzb7dFinDJJbKmZC
 IGar208IR5Azejv2mykH5JiIQkviP4WU3fA3CIM1wlpYC3+2BkKW020kYvSOiPl9423x
 kyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907125; x=1792511925;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DZuhEJteCjiBcxYMsQ5/Kb0n1Eh3plqb2K4/0ypuhTg=;
 b=r163wwIVzgv5zz3MFOJjFq8MxectS3S4ah8bcEVKNAxjL6DaUVYpWGliNw5ct82+eP
 FxlHOj+C0BLlayvvkJcxgdURy/ApcLDd16EOh3AgVUDQlq9Qpn17xfwFbh0rux6lMz1y
 HjvtJkNnTt6xPbD+XeV72yVIYPOnyHVTcuCYlXuJdhRqi9K05ue7zE2VnXUMOpp6C4op
 QlW3DD6rGbWc1GU714uTqH6yyrgeAeyzCWwy96PNDz1jRsr8A7SsXP6nEcw9SCVwNZlr
 1SGoSMJzmWkQXqewDCC9OE+5r5nU8ciV3Uxgrm7KirrTVCxVM2OqiXv55tFCff5NRW6F
 qHjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxAbqUamj5kwXw2BUXRf+seF0EtITZ93X7YNRkr7j2DxgzmuNe4oaF/lTVTA5lRMsrsrE+AhCKK7II@nongnu.org
X-Gm-Message-State: AFq9FYK8D4eeoidQM70Nt355dPl+8mUwM+uBF785C5mjNxsY2MDxAtN+
 fqJAnlZSY3hes0BGIRP0+rOXKlj8IkzF9c9UqO4/jP0xkkibuqj3izAJWyO/9WqPKb5iXTz1H87
 +iY9gedbvOIWPb7D+Y8FbpH058TnpgoJX1ETgIFCdCw==
X-Gm-Gg: AYBFou3J/knKLMKBYAhdwlro8VztQUv7CGxmnSMJB7OCGWK2fkheUXwUCbBVB4bVEZa
 Wiwih84VP7yUVg5CxFXgguyPKZf/DvpLa9p8zgCtELteZsCQxuIwf4scw4T4mR6QNYKJWLDI41/
 ygajhQ+sECnKG/ePsMdElxpxvgGaG8e4112u+rKHTpWLUUzIU1DwW6iZUca5RceNNXrF0aIJhAk
 kP5vrXRsKms9xqLhgRP5oUtuhLtXWvsNG3Ex1PNgZV6w0ouN1e77rLgsJov9LpEuGp9Q/A0923M
 VtJhxtUKtvPjnpCsn4BIdjQ/2WEs9iT8pSjOjneKr11PaF7AES/pljmvm1MIO962B4sKDkQUZWx
 zfhchszZkaAOybZ+U1v55g7k9+pvumWhNYPrgzjY=
X-Received: by 2002:a05:690c:c50e:b0:8b0:a496:9e9f with SMTP id
 00721157ae682-8b0a496a4d5mr20751777b3.16.1791907125130; Tue, 13 Oct 2026
 08:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-9-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-9-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:58:33 +0100
X-Gm-Features: AclHuK-vJ3MrY9cM47TQWMRigAS6YCJDLH3ew8EymvifUYmGc29Q40zWzPPbrec
Message-ID: <CAFEAcA9MzduZYdWu6VSot8SLaQi_MaeKJdJCUS1YdPWb2y47cw@mail.gmail.com>
Subject: Re: [PATCH 08/22] i8259.c: use i8259 prefix for functions
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This ensures consistency with our normal QOM-based naming convention.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> FIXME: rename trace events?

I recommend removing FIXME comments before posting patches, it avoids
the possibility of reviewers suggesting you do the extra work :-)

I don't believe we make any claims about stability of trace event
names, so we could rename them. Should be a separate patch if we do,
though.

For this patch and with the FIXME line removed,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

