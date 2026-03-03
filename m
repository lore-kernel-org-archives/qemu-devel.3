Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449FBEC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO13-0001HZ-3c; Tue, 03 Mar 2026 06:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO11-0001HD-KD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:34:15 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO10-00007N-2r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:34:15 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso5278461d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537653; cv=none;
 d=google.com; s=arc-20240605;
 b=h0dzK+QMq1dVEgTlO6+Ny7hfcLwqxZSYo9RhBALVQEE+CJ9TJr3c8DTFzytqngqYuJ
 YaJIUQ6J3FLA8CSoKBEhm47DAz1XFHndp0Y1H+yeMn2Vbo14n1huq571JHDfK6pHFpMO
 pGJleEj3hBLAzor9hjMx4B8gGJXeQi+EDwXcAGyeZczyB1BgN/DlEZrYtx8dkYL/A4h+
 +yMT8WHczCmLT062Fc2Mr9zuvfeHRpQUskBBJ6jVyPQc3OXe2xr80xBhZPKQQPhWx4n2
 ctwOeBfEF2VSweavyIbW489i9ilMjZsT62H8aeAqWa4xp8KZTDUeIZ0fhWbddjGQhj9W
 2CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0/wlMglP5++N8BWRPRlhE8xjZVP3ThLRbOhbAxWuTTo=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=J4uC6KlSu7dGOGf3RJXijfI17GcYFLEN/VeprgpyGmouAZufs6Yk80YGoSZCY9n9B3
 FjxZ0IkVzqHoOu8ibhUD10vORQ3Y/CaoBJuBuWaUFXoeTfdEqS3bUQZ3cvFHTngDCQXY
 aiANx8UVURCW2hJIGFXWJp0SLDg4Yw51GgZpi1T4OG649N6Yro6libsT3eeHgZ45H8EK
 kdBwcQG27iOpylL4ggJBmPFt3YZYf2i1Cp6RLw8SrllrInIQHnk3uD1pYWvmmCaCO89C
 hzQBlHWX/7nz/eqK5EnyAgcbxhJGyrw1YC1UHn439RK14NJ7LcwXVyu/CYmJE15zjju3
 LsxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537653; x=1773142453; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0/wlMglP5++N8BWRPRlhE8xjZVP3ThLRbOhbAxWuTTo=;
 b=rL2i8pW7UZuxHzCnGGPSqzIdazCBEJNYsEcQexza4r69+7SilS7faSDbfkMc6dBocx
 g9PPPEMAoAsIzXcZmNBoHGo34COjaEdgYi+haaXvhjQVbKHWqY2y6ZaSWxuv3XicnsCN
 Dajv5QjyFSJAPYlm7uMRk+Y4i7NsQedos3DolYplBZdQbnzHh/jCJcLa4BtpiYandgui
 3UoLrjRF9Jbn+723g6leOmue5hF4tQz3qaMUSOzmDeJmyH/qbc4m7VVoe9BZXtw4oJ4f
 F7mkkJ8VBILKb8z6JMOFqhiHlz1SNhynMKFJMcQpremARkjKputlIxzKcvERl1w27Lyc
 c1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537653; x=1773142453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/wlMglP5++N8BWRPRlhE8xjZVP3ThLRbOhbAxWuTTo=;
 b=uzgnnmF58d+jQc0+ebJ9x+p6RUOraIm+BN550JedPocS7PFTrcNbJHHYnOCkV4zmzR
 husR7nVd/yHb4ZhMZ6U/Mn4RCtD0SCZ6PaE8u7sldDIHQ6NSkNb097BsoBBh+w7ZJpfc
 MpgCc9ZRqIpeP6rEBDhHJA/YlAcpDGEgLICZHpB8GPxw3i9JRnxWBEYrCPW0/cfAIw5Y
 fcHWiB1ODSMIl66cx8ZKdZwAIK2AQ1AoGNjcVuUxAP8XMZSMC8vpssME/ou/BYCEMlTk
 fpqKzxqMexFBFnIdEEmBKMldCblT6sVNNTenkbk9bguqPvPRh6wlUUnWCcgY85KBDkV5
 oYxw==
X-Gm-Message-State: AOJu0Yx9tcBG+Z430E/gtzUlOLtdAvuqLf4G0FnhbPZG+hRvpmAr6q0K
 91p3kZ/6Bs9O7bPBpzhPOAGhF1hSsCk+7mxGwU3LtX+JIxXW2NVsNJyP0HZ5wH/arQIMEME+qIs
 taZLdicX6Zt6JYOkNK6l4GJn+sGCdRsOCiGCApRCi8Q==
X-Gm-Gg: ATEYQzwVeiNbkHbT85ZS17VI8lFiv+U+XoAfOkwDdIMWeCrFcxTg/1qkF8JnzKJ6n2C
 hJfK6fQ7IqmBOCJmxmsxpT6LyXqkB7YYZd3vL1Yjw8oa36+Zb+d2UGi8jbhPZmXsTRgAhiekGy4
 fyHLecexadsFfv5H80PRL1pju4R/IQc3nq8sWuOyaY+5avUq+P7eBOmgt9Iv7JUeja34kOt6wZw
 lMRziPJWtqaSDVjaVnlWa+g9BHWG2JV+UnZIFo03AH/IfQp0d0Awfyv4fI8axxuUKM2VtbNBZ7R
 zH8haMF06bETtNQPIO0X0xCoATr6EOsIPVTSCO1qxutPnZBNxNqSUpD5W8CAUxNpWxs=
X-Received: by 2002:a53:bd11:0:b0:64c:b5ab:7113 with SMTP id
 956f58d0204a3-64cc2328544mr9207806d50.81.1772537652992; Tue, 03 Mar 2026
 03:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-9-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-9-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:34:01 +0000
X-Gm-Features: AaiRm51k_m6i7GX44xCmo2JXbikyXY2uWRlsDJ5ZliaQ_ROwM0fKpOitwMrEu5o
Message-ID: <CAFEAcA8+Xj=vgG5s9y1Mk=NcJKk2x6=x9RntR+3deaqtk-JThA@mail.gmail.com>
Subject: Re: [PATCH 08/12] hw/char/serial: Avoid implicit conversion when
 tracing
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> On 64 bit targets, the MemoryRegion API passes an address and a value as
> uint64_t, so use that for tracing. Keep the uint8_t for reading since
> this is what the device model produces. On targets with less than 64
> bits, uint64_t is wide enough to avoid narrowing.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/trace-events | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 9e74be2c14..a3fcc77287 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -5,8 +5,8 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
>  parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
>
>  # serial.c
> -serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
> -serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
> +serial_read(uint64_t addr, uint8_t value) "[0x%02" PRIx64 "] -> 0x%02" PRIx8
> +serial_write(uint64_t addr, uint64_t value) "[0x%02" PRIx64 "] <- 0x%02" PRIx64
>  serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"

We know that the value being written fits in one byte, though,
because we just asserted that size == 1 before trace_serial_write().

-- PMM

