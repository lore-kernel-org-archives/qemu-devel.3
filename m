Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E5CCF2DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 15:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viDqC-0002md-NM; Tue, 20 Jan 2026 10:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1viDq6-0002ja-59
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1viDq4-0000xh-DY
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 10:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768923613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFaEoJOo9PLnfQoHC++Vr7BRDm+IJPN9NLdi1in5Kr4=;
 b=c3gZCFmTHqC8pm7QkQn/3VCRchC3Wn/1N3Fqpz3wLHSQRW5A0hAKQ2kX59hbD/Y2ZtAtTk
 QVUldiFZvHvsF8OuzKpBlf4alks9ILRKd/LKiIlWKBR3k0glI/PvN1fMCAdizyjDuiVJPy
 p3gauIHd5WVuyxnV2b9MQGZvmDTuacM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-jZO4gTdqMzGA8u-C8ExFzA-1; Tue, 20 Jan 2026 10:40:11 -0500
X-MC-Unique: jZO4gTdqMzGA8u-C8ExFzA-1
X-Mimecast-MFC-AGG-ID: jZO4gTdqMzGA8u-C8ExFzA_1768923611
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d5bd981c8so41997185e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768923611; x=1769528411; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kFaEoJOo9PLnfQoHC++Vr7BRDm+IJPN9NLdi1in5Kr4=;
 b=YV/sZgaZbeueGBCGL6fw0hTltgQN6PZc6Yufe+GHIrcw5J66viOrifd/VyMM4JKOGd
 2pdE+KRUgIrG7AktqZ6dpFGN1r677xFEp6xQpnlc3xAq7B3tKNfixnOF+BR4ugZhTTSc
 AYHxuMEreTPUetU9QnAZytJ222LGTzaM8rfcRhGiCW+iWteK3p8iubNBzd28aAN9F56L
 lZ+29box/KdXAoxHo4nd3gVYKR/iHem+NkGY71H1lw/yhlaPgCV+U3NbAV91xfvLOZJ6
 XzVvuMWsajqFhZ1VW7mR23okWDXHxBg1T4mHpcDUDfnOTl06jyFcdSim7fU+LtFIUMhl
 Hr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768923611; x=1769528411;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kFaEoJOo9PLnfQoHC++Vr7BRDm+IJPN9NLdi1in5Kr4=;
 b=JP5veoVLJydaoWSTF1Kwa8zxhC6LgDcy5VRqbdxlh6/68Q6or1gekYL/NaWahtPbsz
 R+WrW81UxYp8++y0bKFs3LG4NeQ419e91zO1O+WA7ifnMumtaeD/tIcvO76/V2XHzyyn
 Rvz5fEPszE3082+LNDctTAOESrXB/uwJdrPlOsSxsA7RxcP9V6svV3NMlQ16OAiJ31FI
 RmeNChPOWHsHY7J8rlgvWb8x4TERKY80le4G+SXRpaZ+5hdL+30oQyeZFhdX1C5UeOQV
 96eDp6L9le6gx6QHRPU6aQlhX1k/IpltvTMM65pKOFFo2IXZV16d2aSO247gUEVppE8+
 VTpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2DHAzc8HbRspLC+SMuMh8xPI+qP081iyF1062JT8KA1hcrQg5nbsSkfHQUd2ipk9+EYew3QJsr+JH@nongnu.org
X-Gm-Message-State: AOJu0Ywy+V3ttNPk9CUySeqB3cqNQzCt+6owXkpC4+HO4yZRIQaV5MoM
 oK0pq0sQA9i5UXBLlv/utroJqhGUGzks7HZW6BjTOoTtQrRtpSmIOuc5orjEi5lejVpygspSekK
 KSlbCxdM4GNHOP3CgdpmrPkffOlCkKGwaMmfC2t8lcj12lzPm88PemN/b
X-Gm-Gg: AY/fxX6Mh7DGFwutQdGLJFLvXJ4Z3fvwVP+Sv36fx+HdMz/Q2AoJMSJaY1wHBsOyL5T
 +7Oiq/3BFP4T2uzJSLv30LjbQUV3RgTYasADr+sTTGFtkbz1mIYG7eeHKn+blbIU0ugcaiRedea
 oWM9eHE1/RMGmovwtYMImQVyf2h6KY/5Z3mf8g6cSQ+5X/oOC+6erU0pdPb+3hhbcdkjzv+wS8X
 tR4t1t1QBYL+/ipabNcVrRxkbMxsWmZuaY6Men+FBKv6A/n+88SPHj3iV6rDV+cVF6KiS1vMyEt
 zt9uaZ8EdFcKgZe7TBc8hX9Ktl4+m2e+aiZjjCi+Hu1Z2xK7ZE1U0pFLuzWXzFiiHL8yFM8WEwB
 ejEMhHQdMvEl0v9iEvmBlGyhClWuJmAYwe/DolQvWPwoq7GqF3CTR8dr1eoY=
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-4801eb0efe0mr209213705e9.31.1768923610698; 
 Tue, 20 Jan 2026 07:40:10 -0800 (PST)
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-4801eb0efe0mr209213185e9.31.1768923610266; 
 Tue, 20 Jan 2026 07:40:10 -0800 (PST)
Received: from rh (p200300f6af31d00062ddfb9151537832.dip0.t-ipconnect.de.
 [2003:f6:af31:d000:62dd:fb91:5153:7832])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fd3bcd2sm117566025e9.1.2026.01.20.07.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 07:40:09 -0800 (PST)
Date: Tue, 20 Jan 2026 16:40:08 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH RFC 0/3] arm: demuxed ID registers (CCSIDR_EL1)
In-Reply-To: <20260119172732.140613-1-cohuck@redhat.com>
Message-ID: <b64a662e-4403-c21a-249e-c2b99a1f980c@redhat.com>
References: <20260119172732.140613-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 19 Jan 2026, Cornelia Huck wrote:
> Note: this is on top of <20260105154119.59853-1-cohuck@redhat.com>
> ("[PATCH v3 0/2] arm: move DCZID_EL0 to idregs array")
>
> While trying to move to an autogenerated cpu-sysregs.h.inc (so that we
> may keep a common view on registers), we should first address the ID
> registers that are still kept outside of ARMISARegisters. Other than
> DCZID_EL0 (addressed by the series this one goes on top of), that's
> the CCSIDR_EL1 values kept in cpu->cssidr[] (indexed via CSSELR_EL1.)
>
> My idea was to provide {GET,SET}_IDREG_DEMUX helper that work similar
> to {GET,SET}_IDREG and operate on a two-dimensional array. As a side
> effect, this also allows to get the values KVM provides for CCSIDR_EL1
> (which are virtualized as well.)
>
> RFC because there are still some open questions:
> - The demux array cannot easily be autogenerated. We can get rid of the
>  ccsidr[] array, but we now have an autogenerated entry in the non-demux
>  array that does nothing. Both are not that nice.
> - I'm not sure if we need any compat handling for KVM (on TCG, everything
>  should stay the same.) In theory, the KVM interface allows setting
>  values from userspace (I didn't try.)
> - There's a slight disagreement between the current code (providing 16
>  entries for CCSIDR_EL1) and the KVM code (providing (7 cache levels) *
>  (data/unified, instruction) = 14 entries.) With FEAT_MTE2, we might be
>  needing 7 more entries.
>

LGTM!

Reviewed-by: Sebastian Ott <sebott@redhat.com>

Thanks,
Sebastian


