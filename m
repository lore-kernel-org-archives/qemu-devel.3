Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF7CCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkJs-0007w2-7F; Fri, 16 Oct 2026 11:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkJo-0007tG-Rr
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:58:05 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkJn-0008VD-Bk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:58:04 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0e21048f8so1007837b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166282; cv=none;
 d=google.com; s=arc-20260327;
 b=fHrhYno0ktWx3JkyZsPOc2Ap9tXSUb3CYxY3O/P+7LZmO+2UFuxzTkY+VrkHRJJJBO
 FgWLYVe0wmKibLU+++IrdTVsf7IfxitzyyuYt6OP3jR7bWdB3jKjbGdtWI7KpLFBxYrf
 kgC0/rBXHgFebABu3V7MMQnw7QrLpC+MCquuJxxB84DyJ0/e+yKkoEEMseyqQzyICR7s
 Rou+evveyKVHvaqDOnEF3FyPGs0Eq4PuKQXMSzR+/95O0c7zUitVI2KwHsFE3kUYCHrt
 RPFWFV9BH+16dF6WQ/rd/5Jq0vTRyrslVhumF+rQQoTvsExMvIWo3EXv7VBBg+QkP0nK
 YQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tzUyRwSvSTZpajfUFhAFqOVRPdXs1HJ0Bbm5LCt1+4M=;
 fh=a6Z213NbuE4BktKj2UQRZ0p07Xak6TcdCtahdFPrK8c=;
 b=Hjm7NwhddR9faVFjSdEhY6f7RGT2lvAQm2kEbzkgAWGBFRm9DoWQJJOixOCKXgc7ag
 A/PlVTDya9GqfTbDxBv0bIs+idM85QfV8cCFzvyoBvNwA+PPK72QpIW2T27y+On2oeHE
 fqunNtc5ZJTNoUzqMMmT0lvbfTbfKugJlmPTHQDliayAybKq0hGz7+kZD2YYzUtMxAxV
 da29J4cDpwfNxryg73/c25KYHQR/Oi+E1t2gV1R9MsvLmJSc7M+Vbcri24JU4BQQjK5T
 oOkA42aFIDTXK67ZIqnd8UJulpsj0tTiBo7Nu07JDBoPUL/rQ9YQxgeFsU1TgwL3mrVk
 k7JQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166282; x=1792771082; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tzUyRwSvSTZpajfUFhAFqOVRPdXs1HJ0Bbm5LCt1+4M=;
 b=OBUcQP1zhNDzjAggl93WAuogNlRPAeCVpizJYDeIrXLsoyd9YHPt/T/ah6y7kjS+/y
 GA4qqA30tg2bZkng5qaPK/7WT+szFJ4ueTma7+Dy5oGsK3LwEgPEF9atZhXdluyfPD8d
 0iKfjccym8AHqtKbS+rTzpz5UvA+h8YGCBGNunxxUm+kOw9Wu+i6doKMRlnmYU5BUNFY
 PkPaIEjmomPTmhTVMNUJhEpLBOze5Xz1yH/4L3+cB26DFwGXTNnTfspj3H3SG2TLaVFx
 5r0eAtq+u4JtF77dmECa2i5ISf60o4Jf4F5mS2GD6j8nWNyJoKeWLgI3p8GLMp5IAaG5
 WiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166282; x=1792771082;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tzUyRwSvSTZpajfUFhAFqOVRPdXs1HJ0Bbm5LCt1+4M=;
 b=f1yJlCcGFLviSA5jdJ5v+5ujid23rrST8KSN1xMWbHbTsQwuSsUWqAGY3Su+pbVItj
 O9+mtDOD3ApHYFyYiDm+fKOu8EgZvK/FevWdk3k0CCbIqQkT/v82k7L/921JYR3sK67N
 kut+RK6I7atlmE1U3B5N6byj+N+wbrOhrBPxpDcifT46j+yT6usLV1j/IdXaW4pTef+/
 OdWZ2vPs8n19awnvV4mFRL6FmGvRQbmv//wAbEa+uPihXIzKR6O47x/OlW1aiRNHZRgt
 i7vNm1RJ+iwrkmeyXuGTALREdPmBOsIo/mh7tCxcgm7MQKda1IOwgj4lZb5jUC7EcyDA
 34gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+rBV5qYRDGurYyqf1gztViEilNHjvAiVk11KHU5FX154byfSS822s8aS8W/Da3xCT+nTTlg1OLQ5X@nongnu.org
X-Gm-Message-State: AFq9FYIOsngB8Y88lfhDG0YZvNAT6rw+nATHlewreSRU9hGZCeJnuEC5
 5PVguf5HRH4ht0CvjxsT7rOUjFfRpkGtsQjxcME809w6oiYaEQMYBdvOmZ4jkB2IDTS3mb0FcOf
 C4hVAxnkPS+rSA6WZIksmreoCPSwHh04OyvpQIpeSrg==
X-Gm-Gg: AYBFou0LmNAxdGVJ3jOUxfVGVdeyLqgXzO9lh+Xo0CtN0iAGHOwlpWsNeXyQKzQBOun
 OLM7bpRBbJvRhuoO13AR2QD7pEHDt+xmDL7PYCcz+FHhbB3GO76cxmTdwFkOXXPsJd1xBciLYkg
 MB0fdnGcT7u7s1311qZ3tM8NSAhoXByWokouECf513jdyfpXbVQuu+l6Kv5q+s2aKiXWkWmLXqi
 viCiExvEDubEbAqMPOPowuTACx5Wc9VknrzlGycDXW2FHFsS2Yv8i+3hfhaCcuQwOBJGiZvDx6P
 aZ/no++n7vMeFWTokp1/4o/fhIOnefBN8O8rp2dZROdW2xcNzkzIqiw8PRL+kaoWN2F72PwsQce
 XMX0QiPRIVNXk9u5d8RiGpEnOO1nl8NOR1SpWkLs=
X-Received: by 2002:a05:690c:29b:b0:8b0:e680:6157 with SMTP id
 00721157ae682-8b0f21966dcmr1741227b3.39.1792166282248; Fri, 16 Oct 2026
 08:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-11-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-11-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:57:47 +0100
X-Gm-Features: AclHuK_Xg1yShmZzjS6zJOIF9yk2TdSWaMxrKLq6lygSMNlA25-z2dLMhnrPNhM
Message-ID: <CAFEAcA8iyerWJRZq-BTWBVKfmX9P=+Yn+QwOza=kNnSiE-DdgA@mail.gmail.com>
Subject: Re: [PATCH v2 10/27] kvm/i8259.c: always use cs for I8259CommonState
 variables
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 16 Oct 2026 at 15:23, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> The use of consistent variable names makes it much easier to follow which
> fields are being accessed from I8259CommonState.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

