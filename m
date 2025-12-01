Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF3D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAaJ-0004OV-4I; Mon, 01 Dec 2025 15:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAaG-0004O7-Ly
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:33:21 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAaE-0003sE-Pv
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:33:20 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6433f99eb15so3422810d50.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764621197; x=1765225997; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eVUYFPYTyt9t5ejLB3t6GWlbmdqe5voIveoLizx+kUM=;
 b=B8kUTye2eMule3ov3YWm1h7NNeNbLjhJmbiqcnm43zj7zZhp4NyxMQwpjUnESPdW85
 THa7H0DFRyXmIT/7o3cnmFbdLJjl+VfUF5NtAi6F+bFi1doLq2eb7eS2KzOiCJ3nasnW
 U9Gng2jF17fpL5mODLYX1c8+d61pw3mV8Jfs6miAc3jQwkUKiiNJzE6VUKi6MTFjDNpz
 vHLhao/YJde2Ysim4bvfvwUxRGtzo7SSAoImGkdhqQ0MOouOT1Bn8glIMbc+B42dn01V
 keqrPUQxwirUgExBxqMepR8i1dbllxYqIxVGuYhIkRxyBv6EggL8fgjA65vGTsO1FHI8
 bqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621197; x=1765225997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVUYFPYTyt9t5ejLB3t6GWlbmdqe5voIveoLizx+kUM=;
 b=qnAN4dD9dH/QGVBF4LNmJYEEc7CiZsJxxvnlaeVu2Rz01gWp9CzQt9Jm/6YR7n5UHd
 KEg/PgUz9/JBVZnNeWvK5N9KYEai90NokdA6uPF+8cuxxM+jQAOVK4FLXg3n8NjXe/6j
 Bhm/F1xE+FgtN4seRnXSx8m0IoOApTj61iHrrZCfxEXR/PAZyje638BOWSzrHSl8n875
 EuLSuhhJvImNAxeOtv7/248XivNODXlDOJOs8KQRD/eGVyunXhYEAdYRzVusQflQvgJg
 9y3mFRSSQ0rFL4vEyzhwbPndnJeB97RG0sqQoHkozXB0k0kRQkZDEGGjhnLt7/oRIL3a
 HnrA==
X-Gm-Message-State: AOJu0YxGHkafVbprK03QcXva9LrutaBD53AR2x2jPyP2eQOQ8ISCE0kN
 zvtaKhESdc/4SGd7+QFCNVmeTfH+yp2jp6cdWcRDFtSUj9vVSDae93mHWRwe4cUPfo0uE06jTQa
 FzTWcKyKUKbDrUzZb//MqCvDdXtYafHwnZ82hz8mXBdh1l6MDSIoVL3k=
X-Gm-Gg: ASbGnct5oxIEl5pkyGfOCFRjl88lF+cKHvCTJrcilo4iCd7AAsPyzdmiy0dMKOBsNm6
 nsoqclHzZKB0x0jzjw6qgwW8xiBCV+sOPDxVidCJF/OvjutNRDCkOLUcYmnOKNPiQTzagGYh1Hz
 3rG0Wm5F5pdk52FQxNwqfWjytjkef+n8I9QYrTHR26Ku0IoaEWVQLaQ7r2EdMDmvh4CnrCdmNY1
 wVbrLrkRRCJFvBsBZQMfQJbomiXE32ZXT3S2IpgJbXgZmGdpWBbjUl1ne6wTQrIkoA4GnZXQMdT
 l3Vp/d0=
X-Google-Smtp-Source: AGHT+IH7x9OTcHl3uf/dt2w9hwqK2ZCSDi6aO/7/b18hMpJO/7SJNofe1KgJtfH98UJKqQSTPkfh/s+uR11Z0/ydWM8=
X-Received: by 2002:a05:690e:1594:20b0:641:f5bc:694a with SMTP id
 956f58d0204a3-64302ae39d2mr24004496d50.78.1764621197356; Mon, 01 Dec 2025
 12:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-11-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-11-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:33:06 +0000
X-Gm-Features: AWmQ_bl1z8QV09b9YqAlpF97ZK0_DeAPm_sd1DrnynUtCwbO3vU_bxe9joDJHKE
Message-ID: <CAFEAcA950p_B0HzS85H=+exBjijJXa7-L=Xo0EUfujQWcBJm4A@mail.gmail.com>
Subject: Re: [PATCHv3 10/13] hw/arm/fsl-imx8mm: Adding support for General
 Purpose Timers
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> It enables emulation of GPT in iMX8MM
> Added GPT IRQ lines
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

