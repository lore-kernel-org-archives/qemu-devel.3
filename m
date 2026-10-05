Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF43CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeyH-00014S-6O; Mon, 05 Oct 2026 05:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDey8-00011o-03
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:26:49 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDey6-0004nn-E9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:26:47 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8871ada1a26so10014097b3.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 02:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791192405; cv=none;
 d=google.com; s=arc-20260327;
 b=Hb9NlDGUiY1MMbVk1gttaUWy0otZnTpfHJJYN7ycoNlA6lyF1mpCMRLP3T2nB2kPxf
 OK/DV1CRHVtqfaqm28+GIrZJ0OlQHrwCEBdb8bMmTFew3P8cxRX4W9lU8QHnL4bCaPoE
 VCSRVCKLyJkNRVzCOeD5j9jUvDorY+33tvJZAEFi3ylJAE5kiAh3OU3W/H2nuAZWQ3TQ
 MIQKlP7r/ytjRi7p/Z9eQ07HymOgvJwXcEk4HAT8FqwNWElcNVCV0vt3HnB/+kmz6B2U
 Xq0iQQVwgBifEKALbU7Vic+cotJtLWzXd095yOx7txUqQOatm5oXE2VpMGifIHQHrmAc
 I8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SUdZuRArbPPhWnhhfDRweXyjb942UMMevw0+7NOsx98=;
 fh=A9u0Chdm7gbFJTDURU4r8HUIXU1HqDknufETpUPnTOQ=;
 b=ai+vDLtOj00ST0LGYEdrpArFZmotQlTZmWCAGIu/XgfO4my7IdribgKaKxE1oIOq19
 eWKWgTziYEAHspW+EXtsJB/ubbykg88VAEBd5f/Xs6UQRixsKLQ68kYWZCFSdxWvOwpt
 xASxnYQkB976rfMoB6DsXTzWXHuV/VpgqCXNwxF84MNOcK7z2vfiX+MyMioVAviNrEcV
 RkDfBVrPrGdlScX+39f/dE3U0f3WMgOrnqfzr0ZJ/R+dqvu3LfcJCgPZJRmLxBgJYM5z
 k730xCLnD5ronQVlt9Ed3JCNh4dCDTSMZTvzBQzN9LangSMyR48AkmIKsZ+UKvw+Qojb
 H1uA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791192405; x=1791797205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SUdZuRArbPPhWnhhfDRweXyjb942UMMevw0+7NOsx98=;
 b=XiTzt2aLzQF6/f2XVl0cS+4fDpXzjs4wHDEog3/aEurgcoI2mmZ7cRLKEqND5UIqGZ
 Hx5nuNbb5XGoADDi71GSfGY601EwM88ZYXKkTViQySgYU2jQuFfvWlu8VDUtlWquNjRz
 tNE5bNcNzSjwnM45/GmBPeyDPcCkI7SYeVZHI8B5dXkjHI55B4I6y4uHRdjO6zfFMnLa
 uzE4JwyiVYQ2oYsdQ8foD7PhROVPZ3k30OTWhCSUGE7IIBTlae3rv/NGxEFa9QLe88de
 YMmnbuo6+ji+OK7tGHgx+xZWnxUcqpMTm0xN6hf/XBr8hq9iv7hx0zxHdnzgHymYwir3
 XKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192405; x=1791797205;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SUdZuRArbPPhWnhhfDRweXyjb942UMMevw0+7NOsx98=;
 b=TC3nP+bqPUUjE/NtDiQKTBMeXK2ri/rszNiz0cKCHzn8+Glpdonb53mXI6twMSmT63
 ivTJOqF8qpMP30QlWIMJspEr+efpOgnbdh2JmOHR7uzX2gmcQ2N+JpIDq7CejLygf7IP
 t3TmnL0BnEm5CKSQgfgWE54cQ3TnsZRqxcNkcEsqfDCzZJbLvmErmEPn2ADSej0z7JXI
 cQzB+n8+yxnbHDMLRybgzZgfW+LmmIEF/Gcu6nlXX+eT18YomUFP03XKNYsY8pwaskdu
 hDbhiKDNtl0BHTZ6jyUjoTTlUOYLYL5ay89tgmDIsDXMU6ha8yAy5Ly7sRUE6dxszvHP
 svlA==
X-Gm-Message-State: AFq9FYJBD1O6a3iEN2fv5thR8ZsI1hnlkUIFXeYaV6QUqeeF2rhtdMzo
 0qgassBvLDVXq2CNqLudnH82vo577sPndHwrPnRaLUFmDfo+uYKxP/p5ZMmfXlc7fgFg88leIMd
 30tArECMrr6t5axTc/1L44eU9KNEgoiIlMuLgwe7EMg==
X-Gm-Gg: AYBFou2MGia3iikWm/cmCievq2+Lo1f6nccA0EzFVzOYIvHWf+WRmBsrD/zBFnE2VXB
 z6IGLshIVTuvofP3kLMKuQEdU5gTP7BNwTSu0PISZHVpQhRDE4Dwzea7EAh6UztpRKljvAl2QnS
 BWtNlOvzlzAytMtEAIrGbhWG0oI7JpNawgSS6sp1hRJFcvy40jFmlNi0W5Bjre+BL12fhD6cj2p
 kDIusaO2+pIrVaBDD3NeQIETE4o8y6mgIal6UxBFGaQZCrso4RmmHggBx9du6wRYNjZd0Bv4FqV
 iZfxkz8/RfNhYqgUAgpwEtoDn2pUVfp0GGa5kchGLN5g8mrp+636DzER2JSEjhtiE5LYmNdIF/S
 Kah2qeGMYY79nDjR6zJRJW6RdMxwi3BNkUXM4sh8=
X-Received: by 2002:a05:690c:18:b0:8af:5516:271e with SMTP id
 00721157ae682-8af55162abcmr1384967b3.15.1791192405150; Mon, 05 Oct 2026
 02:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-25-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-25-ccbef537cbeb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 10:26:33 +0100
X-Gm-Features: AclHuK97AolZCOWG4uKZjG6q87HoqkcvRQ9ivnYr3nBGIiniksN0A95dlsK7oF8
Message-ID: <CAFEAcA_SEJr+ZC-SgZxzY2x8Tuu9HzW_HVDrbu4yzAj2G44Q3A@mail.gmail.com>
Subject: Re: [PATCH 25/63] hw/audio/gusemu_mixer: use unsigned literal for IRQ
 bit shifts
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Pavee Hui <phui@google.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 4 Oct 2026 at 11:26, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Voice ranges up to 31 (NumVoices & 31), so 1 << 31 is undefined
> behavior in C as it shifts into the sign bit of a signed int.
> Use 1U to make the shift well-defined.


This is *not* undefined behaviour for QEMU, because we use
-fwrapv specifically to avoid it being UB. The change is
reasonable enough, but we wouldn't be doing it for UB reasons.

-- PMM

