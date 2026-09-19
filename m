Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5DBC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x82eJ-0001wa-DF; Sat, 19 Sep 2026 17:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82eH-0001wS-Re
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:31:05 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82eG-0000B0-7e
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:31:05 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso1787076e87.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 14:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853462; cv=none;
 d=google.com; s=arc-20260327;
 b=K0pF0Zfb4Wn4gKgevWtSohSKniTCyDTofTydDcjcOe3BazQfBoLyS9ClMd/ks2zhFX
 leLN9AIQGojAe+nAQieKkgLs1ulDOuWQ2DlH9azT1/qtYcQczDQqxSv4uQmyY2TtrmW2
 ZeG1VT64yKmhUEoKTo+iksRnAzN3iNyq1evELlEaG3bSQrSgzqJg4JPwL1BlZdY2F+QR
 PFcBroMDrgb1yySru7fu4i0CXMLqQ2rTLQaAn/XcQkauRQsRDCP6cIM8yqwSnSFK8Ek5
 IGpxHpweexDQbCLCencC+yHmFzApivuZxtNqp7sDWjONwZ71n95BNViECvLAs9FsEsvj
 QVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0LdJm2HET36sciMeKIXZRFIiHDcn0AKfrZHja1Va5b0=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=gTsxei5LlSeyIEEgIg+npAOPWKuRa5Sj8ZdvTaOUmHxYP98uhFSdn5T8Ajcu/rcdma
 3IupALatMawg75JDmDYCJtIGGrhKP5cjz6lQBgvr7lFrslnqgYIwbe11OLclw4TfmsVi
 VhuV/5FnxpbV9FlQjy6XkxMuSPwGaFM3MjU7AO2CrcJq7GMRTEeBmiF8aGDCj/PDTpBc
 77tNRFMv7k/KJ8ogRoUSxdyEKajAa3ckbBMxgzPdpofOIkdV0Ta+vG5jAvegcA3Jxcvg
 GPUu/VvWPYLBmCv2OPEkCf8bWQx/2OuhgVuaSZ4IIUX6/XaPPOygPVBxLwbx0vaHXCOS
 LQpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853462; x=1790458262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0LdJm2HET36sciMeKIXZRFIiHDcn0AKfrZHja1Va5b0=;
 b=CqRJtuoWIE+/hagjWBPAn3jxiT/NpC6Aa8iE+UQwafbdQx7XaBdnLxrdDC9gJNal2O
 Lc1IzkSBYS0ummnmYLGeVzqMLkamWvMjD+zGlyWkju9IvpHWWaxzrkvdm8v/Ex5d0T4/
 5405dPNlujDy/lBq/fPdGJ6WVBrTARHUi0nCxGjws6uwB7DzdAyr+2MTGbSEgxhcI+5e
 52ste/EimOd4Im7sewynbE7gzR2MylV7wDY/KvYZA8qFdHSV1/x9iN1BkAhmS4UWo/bT
 h5JHnXqVZfdekZeKU0RgNBtdjW2nqm1uWDc89Etw7wRQt3kMrx7yKUaphj6W22jK40wc
 LICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853462; x=1790458262;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0LdJm2HET36sciMeKIXZRFIiHDcn0AKfrZHja1Va5b0=;
 b=ttmLmEaTOr4/YSObzFn6+g2JobHWrUpN7JRNJvY2Y8n+MdWL0NhVmQ9T1rqkWz64ei
 zDUhn4T01xXySo/03oamy4bHzJz5qelLLYgXgA1y9Ac/SULbwXbXg9lRzj74X3/d0ldp
 TJ/ARERMjpUHsQo1NdofTTDTb7ZJBtKtrnVeIk9fbdhcub6Ry1LdguCRpKFTL4okeDEf
 fxoCQcoq1lOsZCtB5kfTYwq2zOd+WDMOH7M1lK0FntI8erw/vVbMMKNNgv7MUNJTRuaC
 qTjrb7h469k1UGfJ4Syo19syk3/5YLAmlaLjTvTfwXKtDYl9QdoOV4WZj35w+xfUOeho
 jREQ==
X-Gm-Message-State: AFuF++nSe9MtXavPmgSyOc5X/28AZzt53aMWMavWzg/jjSmOgUUnHpZ9
 mvifT5MbXxKc8iqDchNFuQfH5b81oqcq+C8TRfunpeZef0ghfkHY5nhWjVRv8nexNhKGwyiwo+7
 VmDbJ4ql8UICOF7I9HU0iUIiEkrvLFcs=
X-Gm-Gg: AYBFou3WJxN87ftL/y0VU1JbX4Zu52iZ6W28OxJWJ7RkjpwEogGxvxZ8VzEpyTnGCLa
 5mH/A3emK4Hqp7+unuVkEU+SLhBqOI4fODkOwI86A2azyH8CEtaeGABDJ8gyDQ2qXtENbaOngYM
 LE5fN8KC721gzsewVxVmUmhOikqPddHsRm3XwEa8smFLmtLT5ITNX50HJZ7ejefhN24Y4L4ogcK
 NMbB2bhawnALzrEMU+l6+acnODHuB9ENpjf29M/8kO1/D2QGpw58qC5cdO652LdsX7nYouBUfRE
 xSwcDZNnWv5Q6eMXL5V65GLu2InvUON291bpBn5+8rAQnkslT6SlproXqMxfXB9AUswUi8MNoS3
 223jVLy71t5QhOA==
X-Received: by 2002:a05:6512:31d1:b0:5b8:c53c:468 with SMTP id
 2adb3069b0e04-5b8c53c0572mr1408435e87.40.1789853462134; Sat, 19 Sep 2026
 14:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 17:30:50 -0400
X-Gm-Features: AcwNN1Vweu3DJMfb4L7KvQJdy6WiVyXMo8bAY2MmcjTmsnzlMncZQnKXUZPFMX8
Message-ID: <CAEdQ38GUUduC8wSLC1q7guDV_aVYy1LjFd+rKNh3itASYRy5tw@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] accel/tcg: cut per-block dispatch overhead
 (parts 4-6)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Sep 17, 2026 at 5:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> Matt Turner (5):
>   tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
>   target/loongarch: Use tcg_gen_goto_jc_tl for JIRL
>   target/ppc: Use tcg_gen_goto_jc_tl
>   accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present
>   tcg: Probe the TB jump cache inline instead of calling a helper
>
> Richard Henderson (8):
>   target/alpha: Use tcg_gen_goto_jc{3}_i64
>   target/s390x/tcg: Remove DISAS_PC_UPDATED
>   target/s390x/tcg: Use tcg_gen_goto_jc3_i64 for branches
>   include/exec: Move tc within TranslationBlock
>   tcg: Add INDEX_op_goto_jc
>   tcg/x86_64: Implement INDEX_op_goto_jc
>   tcg/aarch64: Implement INDEX_op_goto_jc
>   tcg/s390x: Implement INDEX_op_goto_jc

I left some comments on 01, 07, 11, and 12. With those fixed,

Reviewed-by: Matt Turner <mattst88@gmail.com>

