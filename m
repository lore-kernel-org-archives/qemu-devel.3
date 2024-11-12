Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EACD41D61
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 07:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAl3n-000810-VB; Tue, 12 Nov 2024 02:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAl3l-00080k-Mn
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 02:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAl3k-0006gP-0b
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 02:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731395489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OuCaQiUDDvIZJuoWCQ28UmFA7kWbMnrTmpkhKKy5PP4=;
 b=esaRtPeV3CxGxH9KkNa/CPRpEdULGPor9ifGWYoeIeljxlPXFnY1wqVh/v9Ug34OVwokPT
 hjdUwVeDOqrkYRgdTbN0X88pnqz2S24jWhVZHyd4mCOBnToT3xaWAnz5EdQJ5CqGb+7WZj
 gsLWZmclFy7uJR6rM2rntCdDXDEuezU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-arkdjTVhN_KmjgTIxRuj_A-1; Tue, 12 Nov 2024 02:11:28 -0500
X-MC-Unique: arkdjTVhN_KmjgTIxRuj_A-1
X-Mimecast-MFC-AGG-ID: arkdjTVhN_KmjgTIxRuj_A
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso38021135e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 23:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731395487; x=1732000287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuCaQiUDDvIZJuoWCQ28UmFA7kWbMnrTmpkhKKy5PP4=;
 b=Lj847NinhiG1xf5F39sFOV/T3iE++aUK/NgcE9vFwbCnml01g35aqQpgyktaEfllgX
 GQMsA14DUmXixBwp1RP6l5QnL3rX8rErm5bEshgJevDd04A+JFrZ8gl/F16stEf6DlXc
 hgphysNSa3uAl5Uljomr8Ye+64g/tDIB86Gj15Tzks+r7Z6pDBAs8zkmalH5+u3NtM4w
 DD+blCDnWTEaIlspjJTpaOzxcowYXqa7iwxVi7/8pHTx/rpE0s7DqWocOTpzmSDHvU91
 BWTlaJU8dk4bG37n+3CHK6Nkk66T21SsS6lBex/1Z4JIrsTnHehWLU0CG8fS1oNaRxJx
 mUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0n+zvh3/RoUwdcNQ0VpvS0Tn/DSFSi/B2jDX9uHjmPbJi1U4W3tpZvKaFYKJnPvw7KK9SvXfolddx@nongnu.org
X-Gm-Message-State: AOJu0YzbqK3v9T1ZF0/hW5YI/tBHeOTldWyK+K4USCQuNjKmSQ446dX4
 C9o/ZDCFevVvEZJdeoq7ayq+gawri1GKCEOdvgBK99cnAan9RDT6iO93wBRfUSjGt0FssYsKlUq
 ixsmOgvrXQYBuXHRYlZnM5RTbw2qacRIe429ho5OCzXhlN//3LA6vNh8KwJDuKBTIrfpHQE1Qtq
 Yp0ccE4V5twK4UO5Sb0TgwOMkxIe0=
X-Received: by 2002:a5d:64c9:0:b0:37d:940c:7394 with SMTP id
 ffacd0b85a97d-381f186d36amr13276752f8f.32.1731395486778; 
 Mon, 11 Nov 2024 23:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHOXQYNOeVmN93ptR3NlcNrYiVDxV1xAXWfbg2FK0Z86r2vK/B2CEE6SXCZpVdruVcTFXQjskW1vxyozR5RcE=
X-Received: by 2002:a5d:64c9:0:b0:37d:940c:7394 with SMTP id
 ffacd0b85a97d-381f186d36amr13276745f8f.32.1731395486469; Mon, 11 Nov 2024
 23:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20241112063703.116386-2-frolov@swemel.ru>
In-Reply-To: <20241112063703.116386-2-frolov@swemel.ru>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 12 Nov 2024 12:41:09 +0530
Message-ID: <CAE8KmOwDuv7AR4pEGbq=ubEkrHbkQBn7cz2hJsSYx6YgH5Ubpg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: fix non portable env varibles access
To: Dmitry Frolov <frolov@swemel.ru>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 12 Nov 2024 at 12:08, Dmitry Frolov <frolov@swemel.ru> wrote:
> "int main(int argc, char **argv, char** envp)" is non-standart

standart -> standard

> Microsoft`s extention of the C language and it`s not portable.

* But it looks widely supported.

> In my particular case (Debian 13, clang-16) this raises wild-pointer
> dereference with ASAN message "heap-use-after-free".
>
> v2: changed confusing commit header

* We need to include a pointer to the earlier version/discussion:
  v1: -> https://lore.kernel.org/qemu-devel/23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru/T/#t

Thank you.
---
  - Prasad


