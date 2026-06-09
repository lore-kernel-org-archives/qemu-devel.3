Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD787CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuDi-0001z9-Cv; Tue, 09 Jun 2026 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWuDP-0001wZ-HE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:01:54 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWuDN-0005Tq-Jo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:01:51 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-660ea43107fso5240924d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781002908; cv=none;
 d=google.com; s=arc-20240605;
 b=iWEFl7faQJRzJA9/xOQ2XSkyshtOhnqXTKUr76kqV7srF4oag52gIHCSJnUmfeiOWM
 SzBtfIVjtL2/ezntqroA7TiKx8PZroBampYJaJbJkpP8lV2A887Dn08N43BCJ/ekUFwb
 sptVh9j6wdGCOlxXngWFXlFYF1gVrChHQ+XEHm7Vw+fswab6YB2nwt3v2iWTdTw3j2nr
 hHOqmfYG5AGq2W684Plo6m9HM/V5M3aGQIfizPE0bqeOM8NYus6dQEbmM3dn54vrYSTE
 A42XoNsvoJv+LQyxOuJiYuilPWWkSMUmqjYkF8XwyliTVupjtsFFvwZ9x/W32hdOHBY0
 YTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IWvx6N/trd7GUv7lRQQJVJ/o7RKzQvf1YBdlMGaL8p0=;
 fh=R/1LKvM0o68i4KJVrUSNja+N6WhXTCc88rnpVqvVlCA=;
 b=AgGtnevVwjQBe/otUSqfyWzrq24qgfy5UsNQPXjlI9a0HDs91X1jloAbD2D/deRMaa
 771lcl/8OmRfYCJyYnpmONsWPTu0S69568cW8piViJwqIkF63U/pOP/RPSin9cuPPVlE
 xNeixrUzrBkWx9mu8uUfj9i1jfhXYOwLylhZc6jb1Ku3jIRj2hx08kqgp+mrGvW+JC6p
 PNEE3/2LLJC/BG4hY6rSpkuc5O+Rf7O41GdtU8eM5ZHdQjDzinFXFTKVDrGyP7P9A6tM
 beMrVp8+beaMy7QWnKS8Yej10C/fsJkKslpp3Tmfz6rNfZP5NHjgmaPVaSsXu1QvwA6X
 GUag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781002908; x=1781607708; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IWvx6N/trd7GUv7lRQQJVJ/o7RKzQvf1YBdlMGaL8p0=;
 b=j982zha9PMd0YJB2FolzjXg8DnxZPgzYM+fNPO2h7b43IL/z1IuRFeFZsbN/oBWVyq
 vrVXgYoCQ6gbuGPTz8Pa/sif8FxanER3ffotZ9Jp3Jz069G7HK01Fnp4nZYfAlG9jBw2
 yFRdK8v5cNiSU2Mqex2hqMSgG4mlhsWWtK8TNkqdPsRWvr+0xdS0yt7oCfsGSl/6gICZ
 PPh+7fIR4sfr1Xxt7ZP44beVKq+mKS9evTxsdfnCxjNKOR1XIXAqy1IO8q+VBjeCCD90
 kYDo+aoDyotgdOOPfXIIqViM4OjPXALZ3FdfuHNaTtDwhMCjIVngQ6oS6pqcofyrBVYW
 TkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781002908; x=1781607708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWvx6N/trd7GUv7lRQQJVJ/o7RKzQvf1YBdlMGaL8p0=;
 b=rF7/ZhxSOlLrjF7fP9ybv1zzSwjVPODKXXyzmSQbLE99hgy+lenc1g5IILToysw4qu
 cTRenZlQ8pVLoZTeRf8fQpnsZW+WYzfLXdmXElABdFILIxQbHtocAE6pWfAG0AW6VQO8
 EiWhJ/YeFvNKXNTLKNnh/1dg4uiUyHGNHzMKHSoJuKw82mURI1T3+eo3MTDiGcwJ+UH0
 CpVXSifUdRdYNa+fIheOn5yzGadbZyIv8YGWfTmZ01nv+8bU4Dxrx8xUjWB11Tp4UGzG
 6hG/i+IATWhwat3uDZ5kUmUHIXzrn8E7LPjPV68GMkhVqGALfZ87lKAn0FBPx5YF6j04
 z9EQ==
X-Gm-Message-State: AOJu0Yy9r2n4yZB5Gs+4XpK+yPes3St2YD7Gmoi4sMlVsfPE2MScFHvt
 1+dDgMRnTLPDrJnAQ/LqV/nYxU8TrK/UVp6M5EWxtG/uxuKOZ8MaRNhp/I+IP2+L/y22evQekm9
 DEa0ZvBdLbygcLD9j4blSRjObEqzvA5wJp5ZhBwQ/QA==
X-Gm-Gg: Acq92OEJeQnejoUwJTWp04pF/fXq6686wTkG6p/A9ghN5BOUrP9/mJcYhz0jVgIOoKZ
 vg1AYf9GYiBlAETbxolVPlrw9N8C4dLEOP//vQ5iNRrenKnKSz1DsgVaHp/2zwdcBFx4YKR1xzf
 x/JX2ZGGfgoUihyq9Kx1wyeH3L8Yi7jWj5OG9XGiqKdcZrXd0Y3uvxfC9v/ZTxfSBKDY4GNQWF/
 W/YtZoVWZRCV/32RzoBwjWa6RbKyrJOAEsdxTwwu3ke8OWpIgEZ6bujPJGKKrJoaFTAydreit/s
 dLzJKEE2NPhQrwGlpNByUfJoruDWjzJSJIMUxgt9FEFGgSz84NPw5xbQqbizDAyOeSNMC2j5N9q
 oYW5hhXrNbqFj
X-Received: by 2002:a05:690e:140d:b0:660:62e5:9300 with SMTP id
 956f58d0204a3-6610779e02amr17201153d50.48.1781002908052; Tue, 09 Jun 2026
 04:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260609105626.1038690-1-thuth@redhat.com>
In-Reply-To: <20260609105626.1038690-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 12:01:36 +0100
X-Gm-Features: AVVi8Cc8oKQrydmGDQOBxXvHxwWMlyhEXLAqM4JoePjcSpmZv054gl6whVUi45E
Message-ID: <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting
 too many bytes
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 9 Jun 2026 at 11:56, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The pmbus_send_string() function contains an assert() statement that
> can be triggered by the guest code when requesting too many data
> without reading from the device in between. This should not be possible.
> pmbus_send() already has a similar logic, but it simply ignores the
> error after logging a message with qemu_log_mask(), so do the same now
> in pmbus_send_string() to fix the issue.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3388
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i2c/pmbus_device.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
> index b1f9843f52e..6aa608a2998 100644
> --- a/hw/i2c/pmbus_device.c
> +++ b/hw/i2c/pmbus_device.c
> @@ -104,7 +104,12 @@ void pmbus_send_string(PMBusDevice *pmdev, const char *data)
>      }
>
>      size_t len = strlen(data);
> -    g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
> +    if (len + pmdev->out_buf_len >= SMBUS_DATA_MAX_LEN) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: requested too much data from PMBus device\n",
> +                      __func__);
> +        return;
> +    }

I had a look at this bug earlier, but was not sure that this is the
right thing. What happens is that the guest does something that
causes the device to queue up data X ready for the guest to
read, but then instead of reading it, the guest does another
"I would like data X please" action. My guess is that the way
the hardware handles this is probably not "add the second
copy of data X after the first one". Perhaps it is "drop the
data the guest didn't read, so the next guest read gets the
second lot of data, not the first". But maybe the spec really
does say "you can do things in the order 'ask for A, ask for
B, read data for A, read data for B".

I couldn't conveniently find the pmbus spec to find out what
the hardware is supposed to do here. We need some input from
somebody who knows about pmbus.

thanks
-- PMM

