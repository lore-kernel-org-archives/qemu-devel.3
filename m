Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05FECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64u9-0000b7-Ry; Tue, 07 Oct 2025 06:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64u7-0000aW-Ro
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:26:47 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64u6-0007Ox-Dp
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:26:47 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6352c8b683eso7736495d50.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759832804; x=1760437604; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJfBaHSeb2p+mhjbdkTcOnUg14vCHi5O+7cpMqX2D5w=;
 b=ZzAFQa+VJVTm2V2+tRkTJ0eKVWX3ud3w2EpqukC7k83vYaVcCrrDHfSc3iVsrKnDOd
 hbPB7fX/q1zErczfP79RLhMIK88OWIAmw8Y3yTFY4nmHsiVeFEY3kwBvPBygV2iF1NE4
 g1iLoa9/8kb2tAFLtQLoECCcFAMcRp+CycRaWD+5lxbqvyX3zrLVYM4GqvpJMx9CO/0Y
 216JiUpNdPVxbXYRVjaq/uLfcrLtfGJF92/DouuR2JEsiPyPWolqpcJVuGZ0AgkeObMH
 S+7Lzdh7n6YVA3aRwA9cQTzYORe7pHvZM+573Mh7lo9hTmjsYeFNnV5tpJcR1aH8dIyX
 G4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759832804; x=1760437604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJfBaHSeb2p+mhjbdkTcOnUg14vCHi5O+7cpMqX2D5w=;
 b=ZSTthbs34opI/vKuZrVY/h/3hyPHOWtICV1Auuv2q4Gmosuc3LFzJ/zFNsURo+ycqR
 4VAfgD5J+A9rjqk9d2G3Dq/BNSqOCqRb657jiBdr7UvB7FtVUOE38dNgpB9PYoGLWREv
 QrbZAwTLuONobdoZCyzhlpLFrw5UoK6KdDeOVUYpGn7/RGb6U5cyScY5q6fGzdjidl28
 yUPGLONIZJfTj/1b5Vuj1stj0lSWBsS6CsEGm2671mzKajDSAydP93z5ppxpCZWTgjSP
 IyNdXo1CcoNRYhF+eXbd7+bnewCONgDXKX46S4hh/7XjPN7WVeKun1Zil0lZX7+AwpeG
 nazw==
X-Gm-Message-State: AOJu0YwsZnFriin50vAWxwi1hn9RUGDMkDQC8yF5/nw/r6zJO20/hsnN
 IKPh3ZOnoZsCZ74QPt7U6f7ImvQHz97g4LxFxDyHaH5UXfENAzm0M/tHpb8QfLYf2nW1JJXD/+p
 ckldrErmTGTLIZiiL/cB+ZZ2lPcTQCPpEO1c6gvc15Q==
X-Gm-Gg: ASbGncvI+8zY9glfk9xrFz6QhoZCbQtsB32BusFySQ9O3MeBwprX9FRg4AJtkYo5Q3r
 ja1ya3GVhiIMwqVpmINho+wokniEGulvSPNzaBaN7TaeKTG3YF62GCH0R0rwcGzmi+yBgnHf9jk
 AMeAKjsyvwzlcFfz2vGvqjqgY1Cl5we7ea77x+MxzptSdhDt4IUNg90ypmI3EeIt7K65C2RaYDn
 KfiNFkDZkc/zFo+GY1zxFuYr/GxMs6Cb4I9
X-Google-Smtp-Source: AGHT+IGjAR7oZm3W0hSqPgdWw693/wZ6pY7k31QPSErGKdxfUD/dNifeSsKibkCCYdx/v3ytybXm131wigXfIeQFWxQ=
X-Received: by 2002:a53:ba89:0:b0:633:acda:8c77 with SMTP id
 956f58d0204a3-63b9a0724b1mr12888115d50.22.1759832804327; Tue, 07 Oct 2025
 03:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250926001134.295547-1-richard.henderson@linaro.org>
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 11:26:33 +0100
X-Gm-Features: AS18NWDwmlEkC2hOyR9yw4giDNpAU3Vg4AK4Vrg94-BQWq-H3yYA7jaABKrp8zY
Message-ID: <CAFEAcA_th5UvJOv+a8L6Ezw8Qc-isprCXXUuW3HVCXmYprc1Rw@mail.gmail.com>
Subject: Re: [PATCH 00/10] target/arm: Implement FEAT_RME_GPC2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 26 Sept 2025 at 01:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Note that patch 4 will conflict with patch 5 of the FEAT_GCS patch
> set, and I'm inclined to think this cleanup might go first.
>
> This is otherwise a reasonably simple extension.
>



Applied to target-arm.next, thanks.

-- PMM

