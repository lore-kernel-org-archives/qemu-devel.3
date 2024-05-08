Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1563C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ojM-0000to-D7; Wed, 08 May 2024 17:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4ojF-0000qt-3B
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:21:33 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4ojC-0000iH-Pt
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:21:32 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f05c6e36c8so92689a34.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715203289; x=1715808089;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/A8CnZiJOjyHSowbW0/zPr5X6JZE4vjcH+gB4RVIWI=;
 b=BICnJpGjy0rl3KMt/GNAaZSAz9QRfrK6pGI+bVXVEvXy04pq7+fX8ybjFYSH0t++qq
 hmpScR8QLIqDVDxEO4WC1+nhDrO8OF1WJQDXC0f5mC8WA2dqXngIqgFVB4p3yxuVmeeF
 Fe3brT/dFj5ChAS6YjpRBnIl55/ui7j2tFPT89oBfBrCYLhV+wONRmc16rSSDM3Uf1ik
 OnN0941sv5fixyAEdUWtxmVB4nvdAl+anG61NnUjCTTXufUhLwDsTSgGlegVviRYIAiT
 uTVLIrsg6L7cw8BiXYbg0+k36jbZsQZDCqmpr7qVqLrK94zJZ7uM4cBWbtbkI83y//i9
 68PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715203289; x=1715808089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/A8CnZiJOjyHSowbW0/zPr5X6JZE4vjcH+gB4RVIWI=;
 b=QRAkZLGMBzqSQLyn8n1r+OKGS82WEw7flvKSTkkzTMvP8Wakh12xuf9QEHyNfCpqGR
 q96IbRRcMxfUkqBBgKI1BznOpper6r7tDVk76n/rlO1fToSHxjrKQy5ofs856Wac6nJm
 CUsfXI0XUKQ2mX99d8WxroW5XHqmkJ3Oh3Tx4ojBWQulTE0xxlX54+H33qR7ZfbSFM4W
 014FvGK4fd/qxb98+WvRyhba0AX8sPMhUXSeY5JnEllhp8FytaSausjvGEbEwCQwefsN
 3jIFt7BswfBzGNc/5apmMYbujvLc3hO8jUYgU6ibn8+jECZhyVSkdr6rKw0p9yjOY24a
 Dbig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnMi7SDGu9XJ24XpnGZX0RMjn04BUD9Bz5Y4iauCtLu7pjd53yythrGbJr1A/7JPgCANfdbLtdbK52UnGfdC09NBU45hY=
X-Gm-Message-State: AOJu0Yw/AsJsKCgN+71Yj3qmvM2ug/IhuJSQcRtkq+GA76FrleguYQG3
 n1+NAX+G5oVShbt50DqBqqVz9T5o4+tFIX2xJwPMpnSRo6Etmub4IZDEananH+DwI4GLPyxuoEA
 w9GlIk9jch1QVEMyZc7ivofW8A0+bV7Ic+HOD9g==
X-Google-Smtp-Source: AGHT+IGYbjv6gej+wCyXyXUicv4KMsMmzf0BPYe1xoMKDRTUL5P6+VaGZlUDiAHcT66M8Llb4eliipZT+JFCcFOiY2I=
X-Received: by 2002:a05:6870:1645:b0:23d:4123:6041 with SMTP id
 586e51a60fabf-2409915a793mr4292714fac.44.1715203289230; Wed, 08 May 2024
 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240507143431.464382-1-mnissler@rivosinc.com>
 <94bb9721-831a-4572-9e00-94540203e5b7@linaro.org>
In-Reply-To: <94bb9721-831a-4572-9e00-94540203e5b7@linaro.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 8 May 2024 23:21:17 +0200
Message-ID: <CAGNS4Tb+K5HJeTmYJpoAiizVW=wsmmHzBpCO+1oi8SEg3KKkTg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Support message-based DMA in vfio-user server
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com, 
 qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 john.levon@nutanix.com, 
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, May 8, 2024 at 11:16=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 7/5/24 16:34, Mattias Nissler wrote:
> > This series adds basic support for message-based DMA in qemu's vfio-use=
r
> > server. This is useful for cases where the client does not provide file
> > descriptors for accessing system memory via memory mappings. My motivat=
ing use
> > case is to hook up device models as PCIe endpoints to a hardware design=
. This
> > works by bridging the PCIe transaction layer to vfio-user, and the endp=
oint
> > does not access memory directly, but sends memory requests TLPs to the =
hardware
> > design in order to perform DMA.
>
> Patches 1-3 & 7 queued to hw-misc tree, thanks.

Excellent, thanks for picking these up!

