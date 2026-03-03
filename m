Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16986EC0480
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMYS-0005OJ-2M; Tue, 03 Mar 2026 05:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMYB-0005Mw-CN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:00:24 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMY9-0003HG-MF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:00:22 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so4025639d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532020; cv=none;
 d=google.com; s=arc-20240605;
 b=UiPJz8ZRO4OxHxea/Z+V5wmUKi1wqpIRo+gXO4JXh5GZlMqFBZ8beMKsYUdbMH+GXs
 Q4TLPPJNJHvnVsy9c9+6emyAGDnCtFfDo4zXyUPiH3E7IPL9k1AGMCK0Yv7lXt20Z+mF
 yYkrZf0qVjvamujK3DJz2Rn6YPpuGTJc26slFu2yAye0WFPnKc8JWAE2NHa2KzYJPvJm
 wFJj1SG+OMlMpRdLyWos9uC6QumAaJiJXpuHvDZmSGDoUEQY/tELt8rrUMVrXmmorf0V
 W7jkKBesc2bX3P6r5iPkFb+SP8FXHzRqWiRRLk4Rb9HG8eszUCp6PYvqf1Av1XBs+zsV
 mgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TQeFmCX85bi5y1R+miWM7liTulJFb/kn+hPKR62QfeM=;
 fh=nFj7aFtTYtepbvYRdSQqL+kQtXhnxjpewi3pBwhpqCE=;
 b=V6mWUUfpUxrHKAEH6/Jcq2dRKs1wNgA/A2DE7+sEOz5Zx2IOTz30gKmfo0Jmz1gNEU
 gajWNDO/7jmupUowj8hALRG8GZLcV60B7AhodN2UVBoRAPzgn68BIhqro9lKJwl4ACpj
 nFcvwYs1YGe3BoJKw5biRHQHLsPh+142HPpdoXP8vhK8ntQEOrp0DJTDVGLgBlVGkxdN
 GMXZ9mZTIpWsmsELDheQmH4l963pOPDESFtxs8CQNMa+1fjwERzGKONCLTmV94pQ1svM
 lGxEkriSuzmyTburQ26b0gv6FisA/Mrnut7IwNfUBZ6GN9FerIWeqechR9pXwCNk1ayh
 Tk3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772532020; x=1773136820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TQeFmCX85bi5y1R+miWM7liTulJFb/kn+hPKR62QfeM=;
 b=KGsxNfj6h085qHElAWcyadcmU+TEnsJGIk4WmFB5Iu0KF9tMA4cYWx2j6+Rh8SU58s
 KXpRGw+os6B5gMidYdJbvMfdKdGavuhsikypUyqSjPVxl0FADvmjexHz3cYMfcMtDssS
 F/lmvVPKa3MCYRJQiExi7yKhEtNdav7OB1bhE9Xg055IKVNsWW2Guc4rSn8bSXPfryWj
 b60XOW6xSJ5LxWGpRGzdIAWxSv/oexYVaigJKdKEg5SXXE/HseqIa92wEsUFWrZjA9Uc
 48NhrsIIrjco10Cej/j9TpFeYIj7EUJcWAFgeslmFwcqnTZw2paT8WonlG5QOLKFsl8H
 ytVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532020; x=1773136820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQeFmCX85bi5y1R+miWM7liTulJFb/kn+hPKR62QfeM=;
 b=YlQEjR3Gnr0vFnzSkvcFvOBAMPwiirUUE0A2TiJME01zivGQEcDNUTPcd6iaWOro4u
 sCdS2myWrzhX+Nygg26di2ct00BqHPgNpMpFUQbXHcDjT8Tpsp/wYKet5SRY+ve5g/Be
 no/SLbaLN5h6g1Sls0F2adkwrlrpMSRjORxWK7aB+w1j4/ZsYYa/NxD1OMAyCzVCGwve
 VRhR06rP5FNx+miXi05XULM6GhyDH95kinpmRQffgOV38S4Hj88JeSK8y6gIH3gzXLJV
 5I8MdAXcJUeOmo0+gPeSgOO/jAXNb2XD7aqGONdYrToHWXQFe+jmhZJtlO3anOb2yFKP
 PxTA==
X-Gm-Message-State: AOJu0Yx9uZUsle87uvaH5qHnIHbiAqPFhu+Rs+g3V+8QYAJjHxPcMgHG
 /nTQ4e3zd2zmteM2juK+EUyCLsKfVIjm4zCOxl/NjkOX7ILI5uOw1yNd+WdYxJv2UP9gMPEVh71
 3ZUhgLoW8SlWuTLIGdlEBHwL3+sc99tsW+c6CiZjvZA==
X-Gm-Gg: ATEYQzx7UDQKLDNFYdkgFIv4jGijQbla3NnAqsJkDzmLbvZxwiMDb3IgNpRt7QoiimD
 smPvmTxfJJ5Y/6997J6r47+/wp20NxYUME0jeNXEWA8vhjCMuAI2OBzffL0CB00shSwF1Pi5y7/
 mh4k+CsJq59Q6Hxg4HSE7hB84tsJlfMgQf6IOgRkR6ymAzQNgXL8RIHqKCofbRO3e0bpon063y/
 HtymbRP17YqPKdzIxDZpOzxM6dQS8sVor2WTJsdZg6JZY8edk1+QZsIDXHZl6wxdddPARNOQXEu
 EE4mu3jueYo1T4i0YQTTDoaD+jX6CXfcJnRsOgyGgsGkK0JBzcADVTdNljLgBZ5PA+rVn71tGd/
 IZA==
X-Received: by 2002:a53:d745:0:b0:64c:aa01:55ac with SMTP id
 956f58d0204a3-64cc20caafdmr9247295d50.24.1772532020113; Tue, 03 Mar 2026
 02:00:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-8s+fryKmgU7U=B4Roh4YsQYdWr005Q4opNd-fN3LoQw@mail.gmail.com>
 <20260226105826.30481-1-thuth@redhat.com>
In-Reply-To: <20260226105826.30481-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:00:08 +0000
X-Gm-Features: AaiRm52kkOCFsE2uRP3lkftDHAuXLvgHWjsX7OJ0l-VGpLCXKSIvoXCQKtQaUcg
Message-ID: <CAFEAcA_MMjrEeH3FknE+q-L7ZVZ3iXTMb4fkes=nY2BVnHtfkA@mail.gmail.com>
Subject: Re: [PATCH 2/1] hw/net: Remove the xgmac device
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 26 Feb 2026 at 10:58, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The xgmac device was only used by the highbank machine that just
> has been removed. Being a sysbus device that cannot be instantiated
> by the user, this is dead code now and thus can be removed, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

