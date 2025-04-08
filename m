Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9DAC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 15:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2AV4-0004xu-Pr; Tue, 08 Apr 2025 11:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1u2AV1-0004w4-8J
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:04:28 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1u2AUz-0006LQ-DQ
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 11:04:27 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-476f4e9cf92so42207091cf.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1744124662; x=1744729462; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsmsgzWLL6kVGqLwoLfULN5GphZA4bLGRgW5AWnpqp4=;
 b=Uu0QhN3MVdWGjrjgUYcO8BeFZUWM9QJffw+JT2QuM7dufcq/o77Qit06uHDHr/yRZl
 IVwEuEi2lO+84cLxNXFM7su87ZGxw03P+djkEDn5lrqPlRXEVcxOm0vcbnbjQ/bA7P7h
 OKMJOn9C4gsu6/9uvLkszZNRv7EzixSjher6qJHLMDKfZWEIw+jz+M1FmLJuD0guw6rN
 KSSR+FGLHL794fp8sBVi560cYBTZkwDS8sXROkz7YPLpFlE3nlmLzAnZltLmimkZLwzT
 TKbUaTdPn5n8JAOC+uRFh+Fuc0RK973u/R8Xy7OTHxgQpOJoLviJ2ARxbfRMROAVWO5L
 FvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744124662; x=1744729462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsmsgzWLL6kVGqLwoLfULN5GphZA4bLGRgW5AWnpqp4=;
 b=XwI5QIzE1Bch7Q3HZIgN8mEFiAsmOUe6OJ0NxxjaqFarIAjOaag9Fe2WysPWwRqKt3
 91Anzya1Ufc5pJhMqzsm14Wpp2uE3r9oMPlwUeViguhc1yH++310KsWfGF07bin5tQlm
 YJQIn3KyCbVCu3KQn3LQGWjT+2y/i0WeJuRH1L2U2+j9kijGUEYXKCdpVSBqGAnKfmnh
 TmXQNO/+Yq9273ePXiXvTwnS2TAHRzHRbX6CH+7NYVZxG9MzXDHrO22AjPvnnrg04hh4
 wDmE+oDe0/Xrkof2jC0iTFnCGx0WxJxsOPa7K1j3tA6covRCtC9zK77Zw6xbgYxw6Nlf
 k89Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXGRxQjm0Mj3vVP+87IpHOaSqGpdfCg698SuGgXxd4IV9jhcKWZrGOzpiPMTfcW+vXO59UVdoSl8hH@nongnu.org
X-Gm-Message-State: AOJu0YwLcXG3/yGW61YgiWPEniqLVfonk1jQC25yT1MKTssEtA7c0Q7T
 YC8hLwtrwV931eLGx1DDW7RTP6IYaIlhZc5ienUoYq/xVYEKH2HkJgehemvbwAI=
X-Gm-Gg: ASbGncuuXYiwo0pOzD6WfrYKn1dP38UNSH5un5Er77OhMB0wZNiNRqLwouHr+yYP6wU
 cdVUCVPpJDZC6hSNtvj2EEq5fiF2ywpjx6qIy/xJit8cMNStBwhjDUeid3uK9OQR7U67RYdnBrH
 H3fTUGdg8fbayEMOdjise32JD5wliRhYY9waAfj2ln2x0Y6kDprRw8BXCI3OJnw5F2rpDfthT9r
 jjG0Myhyj946WYJ7KNTGxPjTUDq+2hvJoFMgwqCNZxmxMdn6vzj9HVoOvbzSQxJRodyxvYVDCBy
 pxs6Qlhx7W6x6s5pDrUo0QPgGPtQCKGKIaDxH7rni1QqYA3UVsQsv2pHU4O++NvrgiYLm0l4c43
 ak6PPP5TkHPuBqrmvFwWZGKQ1rJ4=
X-Google-Smtp-Source: AGHT+IFJtDtsqhqndKEDywk5WxR0Uoy5G4rpBDYAgWzK45UFzZFnH64aH9P06dvjmEqEV3b0o0jjHg==
X-Received: by 2002:a05:622a:1:b0:476:76bc:cfb8 with SMTP id
 d75a77b69052e-47925991e1emr272565651cf.31.1744124662547; 
 Tue, 08 Apr 2025 08:04:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4791b088412sm77386711cf.39.2025.04.08.08.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 08:04:22 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:04:20 -0400
From: Gregory Price <gourry@gourry.net>
To: nifan.cxl@gmail.com
Cc: jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, anisa.su887@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC 0/3] Qemu FM emulation
Message-ID: <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408043051.430340-1-nifan.cxl@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x835.google.com
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

On Mon, Apr 07, 2025 at 09:20:27PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The RFC provides a way for FM emulation in Qemu. The goal is to provide
> a context where we can have more FM emulation discussions and share solutions
> for a reasonable FM implementation in Qemu.
>
... snip ...

Took a browse of the series, and I like this method.  It seems simple
and straight-forward, avoids any complex networking between the vms and
gives us what we want.

I'll wait for Jonathan's commentary, but solid prototype (bn_n)b

~Gregory

