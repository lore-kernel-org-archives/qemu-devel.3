Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EDAC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 08:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMkeI-0001zs-Ec; Thu, 27 Jun 2024 04:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMkeG-0001zQ-LD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:38:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMkeE-0002H5-Vd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:38:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36733f09305so683171f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719477509; x=1720082309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KhVvFLYjFI/0fkyQH9R5kCyt4IunVefxlOWmQ0vcCg8=;
 b=Zcq95dIu6SRIvr6cNOXrwCMDpHAghWcSNFDm6NcxMI4p+/DpRRmIjYWrNDejuVvOTB
 +1wZ9fYX4l7/z6PWBds4rAAVSPb4iFtO3xNLcci+mhK2Z48VzEGCGwx80DG7uC8PQJAw
 d5ssSuJK0HvDKzvISzv3PbkPiycBEgRZZM+7F5c1zreTE2hAApxBRm4zTpyqxq447g3I
 dLyuCzYFW8caJB9kFe+j04Hw9hGo0YVwIvVEczX2oR/W6XYpaQ32YOcvVflqq/XwlvwD
 N/R8akXS0p6RhLkK9CsQ5OLheiENVzEMBxJudcs90sp0BLnzlXZoYOgG+2KcAwSUqVku
 eUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477509; x=1720082309;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KhVvFLYjFI/0fkyQH9R5kCyt4IunVefxlOWmQ0vcCg8=;
 b=AKFMSnx9DhEzNobiIxW5M6UK16nIju3S+9nO3cOoKm+NPjbKBoacXQwOjaMKSZGXaQ
 pQAbJwAyRYE0gPhZfs3NLQCOkUo4jxEzUpTGHGkorR1BMde1+9po3E15s1MQWqTUqETa
 Dax7y50Zpmy/f1Au0egouhITS6hpGZN1eUzodhWWFGIghB8L59vzuUqZB7PNS8fpjJT/
 CgdJuYeASb1Tkj82A0H9PSMq7XrtknVKnDb+eDoOxkpFHfzDFGHPoFfGMnkQiyolnhNZ
 Ue1J6qPozJkvn3yuN0RdDZ7hfa6tkDVqRKE7y0C58apfJSziUhvKQ83gCxHX3gcAQOLT
 10Mg==
X-Gm-Message-State: AOJu0Yy/pqs+9BThivhRUgF5+BFZHts0gsMLFZNWsRxIwv5EPjyyqwyG
 drAuTXoDTUPbGimT8WCSWYuBZZaVBzA4ZEQOGEMY/Ik0p4Uqx7V0GOrmgxtmMjc=
X-Google-Smtp-Source: AGHT+IEVV+MivazcOk2Tti1QsKaIEbQ4eNOr2SsYrIG0I51vHEiGWSAZtoFqWJyEIke6DuQ0pCZCvQ==
X-Received: by 2002:adf:e246:0:b0:367:4dbb:ed51 with SMTP id
 ffacd0b85a97d-3674dbbef37mr481177f8f.0.1719477508874; 
 Thu, 27 Jun 2024 01:38:28 -0700 (PDT)
Received: from meli-email.org (adsl-241.37.6.160.tellas.gr. [37.6.160.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fe1bsm1121735f8f.33.2024.06.27.01.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:38:28 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:34:29 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, flwu@google.com, berrange@redhat.com,
 peter.maydell@linaro.org, rkir@google.com
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
User-Agent: meli 0.8.6
References: <20240625111848.709176-1-pbonzini@redhat.com>
 <fnhkw.xyx5xkm2lgb@linaro.org>
 <CABgObfaK+CQTni9MQjTADY-Fode9Fg3hTqSfm+2K8R9DCRJ5cw@mail.gmail.com>
In-Reply-To: <CABgObfaK+CQTni9MQjTADY-Fode9Fg3hTqSfm+2K8R9DCRJ5cw@mail.gmail.com>
Message-ID: <fqdc2.8zr6z4s9qcnm@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

On Thu, 27 Jun 2024 00:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Tue, Jun 25, 2024 at 9:17 PM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>> >Move the macro to compiler.h and, while at it, move it under #ifndef
>> >__cplusplus to emphasize that it uses C-only constructs.  A C++ version
>> >of typeof_strip_qual() using type traits is possible[1], but beyond the
>> >scope of this patch because the little C++ code that is in QEMU does not
>> >use QAPI.
>>
>> Should we add an #else to provide a fallback for cplusplus until the
>> alternative is merged?
>
>As the commit message says, I don't think we need to include the C++
>code in QEMU since it would be essentially dead.

The #ifndef __cplusplus part stood out for me, if it's not required for 
the qemu build then it's similarly unnecessary. Thinking out loud here.

Anyway, ACK and tested-by and rob as in my previous mail.

Thanks,
Manos

