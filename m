Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58545D10F4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOFYp-0002hT-ME; Wed, 26 Nov 2025 08:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOFYf-0002gA-VH
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 08:27:47 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOFYc-0001vc-4p
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 08:27:44 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78665368a5cso64345097b3.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764163660; x=1764768460; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXtMhZdIBOyiMJybbPSMLS2QzpM/Ed2prcithz7IuJQ=;
 b=iBQm4fsX4le91lCye1xwY3Apu3YguMkTNSdwN1cYOa6eMHh/pCwx3OrUpVNVes03Jo
 SRt3eUvYsnZjtHSsAE6139+FcFHtu9cDHbyAmwlCQ1af1YnKrk3q7TxyXkw10jGBWTOG
 7roDFVQHBHbEJqzp0E3RsnfsLtt81Zf2GFptU00fqb70SJhkJTAnHYsmhgEtNdBamfmp
 GiHZrMT/cG0IAkvQ1TbaWiKoZ3n5EX1srecnA67wJfbIa64Ccp+kBVtsC6PV73Oyw8P9
 T2f/xTyDEpLJI1ooJb2Tzqsm1Z4a0qBmmgJsjT9h5yjvvuxiYiegvOh6hHKuxi6EyC8P
 zfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163660; x=1764768460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UXtMhZdIBOyiMJybbPSMLS2QzpM/Ed2prcithz7IuJQ=;
 b=nTe3LxtL92foJyJUiwj6mP39zH9pCqB7EiNRJCA7HuqiKUfVvQgUHWaj2DRtkI9r/p
 QVOx1Ci2QSamlkCcTiuCS3DniXsHnZXOEqMH0oWs2ksSeciY1uQRIUgm6GHA/bDnWcI2
 JxHd/2h/ov8oxqaycjMo1Zsn5d7cn8/q/hXXC86+bbrX0uKJifEm/XRv5TRb29OTJteZ
 6exizMBKwYv3LY1k98BZAyzcSeO3DoLi8BRXrP7P5J6ctVtr+UVvfG5+3UsRKBebIABU
 CLdNCfUHjKDhnEwtiEcUIukR9U9v/w96PFQVEUSsJZT5YJttSrtV0OxLFJG1pRSBpGvG
 kG/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFIZn57tnSSbEU/7WraHlSUeiO5zPFpnvArnRdScGWhKWOiBrzeiYLsFGxaiA2cJ2SYar8dJa2dhrY@nongnu.org
X-Gm-Message-State: AOJu0YwGCjdkRjO1fGdmOJRX7CnjvdTQlQu6zkDfQVFrA5mxdMOHbB/2
 KJd0UAtZTxLkC3481pZ9J4SbCsqLq//ostfXDGeQVVSw3KzNBJ7raH0pcsN0Om1pWSerJ1l5Oji
 gBFj8PLkmCVk2X6MNzuZUU1dAoF3uR3duODnj7pJUlQ==
X-Gm-Gg: ASbGncu3Go7WwIk/ZEKMvcwbHdgsNKSa9kvHCsmPHN69bFGP9bd+fqrd7ui8vUb33L0
 hlxck8N/Fov4RDYxJ/ofTO9c/sz7V7LhXJeyRdIOuStxsKguLoUWViancS+mjXwM7SWBMQZt318
 3zkRnlln+WBvOdVWbzEM3QPvO5oQ9e6kFB5GCaSzn2QqooJ2v3xirSJygPj6YbHL1HIWEPsu+Ei
 NSmP5KEvhVYHwTD307hNOTEzfm/jAMkVd3UjtGoLUpFIVAP/y0z/yPM/b7zOm3LXqOojlUy
X-Google-Smtp-Source: AGHT+IFKedMeTMkf8kdv3tpR+JmIn4jSuuU46zNFAklS6FadDqIbVdtuHnN7h+6gKq6D+O3f8+iXlsKqP4BlPvhfVAQ=
X-Received: by 2002:a05:690c:905:b0:786:5ebb:4837 with SMTP id
 00721157ae682-78a8b50c0f9mr194365557b3.33.1764163660689; Wed, 26 Nov 2025
 05:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org>
 <aSWSLMi6ZhTCS_p2@redhat.com> <87jyzexrly.fsf@pond.sub.org>
 <aSXWKcjoIBK4LW59@x1.local> <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
 <c0aa79ad-d6f4-413f-ade6-43e7609e37ac@redhat.com>
 <87ecplc8yn.fsf@pond.sub.org> <aSbr--ZbqzKVNDuC@redhat.com>
In-Reply-To: <aSbr--ZbqzKVNDuC@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Nov 2025 13:27:28 +0000
X-Gm-Features: AWmQ_bmKYX6H5YMUhakq6KKFeMXErS0qjPS-D7ylXbTaJv0WUlCv9uLdQu-g_3o
Message-ID: <CAFEAcA_Xjzp12zB5Gv1pZPJQYicb1GkoHkt6Tt3QQK0n_YQZ5g@mail.gmail.com>
Subject: Re: g_autoptr(Error)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 26 Nov 2025 at 12:01, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> The other thing that plays in here is that we actively encourage use of
> g_autoptr everywhere. It is very unusual for "Error" to be a type that
> does NOT want g_autoptr, and thus the mistake is very much on the cards.
>
> I've proposed it before myself & Markus caught it. I also caught one
> other proposals to add it since my attempt. This third time it slipped
> through review. I expect we'll see a 4th attempt to add it at some point.

We could add a comment to the header explaining the rationale for
not providing a g_autoptr handler, so that at least we have it
written down, and are more likely to remember it when it comes
up again in future...

-- PMM

