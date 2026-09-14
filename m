Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280BDC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Bq2-00086A-34; Mon, 14 Sep 2026 14:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bpz-0007zA-Di
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:55:31 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bpx-0007Aq-ET
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:55:30 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso1649778a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789412127; x=1790016927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=auGF7eFDwjwKkOoNR9VE/J+MyxShi6ITYEXL2P2CaRI=;
 b=Ut3sdq1y0nH72w9h22Lq5UutThq08qqP4RA0lFqAXxZIiTSQllEh6TAaEM5lLuGzGc
 HtErLMtSH0HSaAZfTqVkxU8LQ7JBcfEGsAxtdm9MJn3E8iEJ8fQmfzb4hgeV8Peqy9A7
 pWxO4pw3UvuOB5PauDAm5xeFITKt8mgH07WR1mqURuGmYlR7tUPW+NH/Q0sZtp+6n6VN
 LT410tPBaUcDh1be+XTz1aVliMeYN0LFqkU7nEM6WC5nS9ktAHUA3ilxtLSntK7MXc33
 ojRbi5jRUkS57s6ayqFwqkDvKoFZbhS9KduDXEgqm8hZeaiZaWs31gNj7imgy16r9W80
 rI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789412127; x=1790016927;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=auGF7eFDwjwKkOoNR9VE/J+MyxShi6ITYEXL2P2CaRI=;
 b=NNiAZM2PGSfEeh9gSGpl4ouL11A5kGO+PRm1CXVHlANAk1PwE8c5xdvAL6nsey11IB
 MWJSi+/qD2rqRvrw9nhohAX8wnPO/mqPiYfnId3JgJiAjw9BExZ7wtSELexjdV59OZob
 ovNdfah3r8W4bON/D8EFbDVOEvFFfOdZCZBrlPjUuDlQUHnmBxoBBFnkke8DxD5CvXV+
 pedwzCtED1tgusbVngTcsDJjjC/YV0VcgV2ngHDzeIh/dnQB5efO40A0CxNYrNvmEkGg
 HPTqwpC80Ca+tXJ1LMjX0IZG+7YlpP5+3buB6WpJlqgTfHKO4Z9khYxQMmlgIUQb5l9w
 AryQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpbonIj99p0+nBSqmokHhHQ556vmVEO1MEgJE6eF0jklYwqJHD1bu8IQ5QXnbKV1x1HfScoLXotaOu@nongnu.org
X-Gm-Message-State: AFuF++nZsA8/07afsiVwMt59kuIjbXPlP0kZgQtx/e+QymsHNSHcdaHg
 qr4khgbSEdehGHp/dcJclI1iIh9f0L6/tqFcEfgZqmihWH8YzWkPRt+9u6uIWwbVyJk=
X-Gm-Gg: AYBFou3OO9aK7wESeZpv2rMyIzvDMnzcYp279gxqA4C7+Ejm/S7/ELyYR7sNrxdaziu
 uGJJSz1bSFjl8m0veqFvP0jZYybu0Aik0JZYOj2eEw+Ry5GegqrCprz2cqAZvS7pColJ+WoecSK
 GyG/9O+K9aWU+MLkD61emgic5qBy+0J2y45z/4i4ToVHGQ7oeSoQ9nbi4UTaob7B+/T+LibRB+q
 LNp+lOxJze5WN26INUP1heiN+6mWuwFF6TeDWKWeniZ2qXI8TTLV/zLDa5EOjDONyVvA0OSstQd
 qXzu2+RX5cvMUzOMlK4CjkfURPJcTmldEESwe8peFxr2KRgN0+XoLt8u8exSn5cnicpPIJzVgB2
 O0i2VCvU4B8Cebhahwc/maaeBMbt1nEfz665E1nzMKMtRnL/k4ZWNIEpQwWBVE6+1euQiXLUCjW
 Fg4Xbfcadwxt+HDbxXlFLyK9E4VyrsCE5S0+z6MZ6uLfsepvFlWpzgUzXKyZpSCJVbsC043Bqmt
 zztjDVLMlXYIRUh884fY/StrAfC3dII+kTGJ1LiUDTU2SCrOz88bMGo3aH3SZQSPLo4Dm5c
X-Received: by 2002:a05:6a20:d28b:b0:3d3:ae0f:5269 with SMTP id
 adf61e73a8af0-3db406d1734mr7870321637.21.1789412127232; 
 Mon, 14 Sep 2026 11:55:27 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8137fsm27043894c88.9.2026.09.14.11.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:55:26 -0700 (PDT)
Message-ID: <95931448-eea3-4e09-a5eb-876534ae9eb8@linaro.org>
Date: Mon, 14 Sep 2026 08:55:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] qom: add tracking of security state of object
 types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> This introduces a new flag "secure" against the Type/TypeInfo
> structs, and helpers to check this against the ObjectClass
> struct.
> 
> If an object is considered to provide a security boundary to
> protect against untrusted code, the "secure" flag must be
> explicitly set to true.
> 
> If it is set to false, or left unset, this indicates that
> the object does not intend to provide a security boundary.
> Bugs related to this object class will be ineligible for
> CVE assignment.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qom/object.h | 13 +++++++++++++
>   qom/object.c         |  7 +++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

