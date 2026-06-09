Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683D3CD98C5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWysM-00070H-5Y; Tue, 09 Jun 2026 12:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wWysF-0006vq-Lh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:00:19 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1wWysB-0001nJ-Rv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:00:19 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5177d1ff061so2366731cf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020812; cv=none;
 d=google.com; s=arc-20240605;
 b=fc6WgDc6nv9frAp2ih6PZXql4BF9Fhdim/yiHPL6DiOSA2RpbLg2gX4y7TmWWN24tn
 TnrIh8aCKOduLWQKQFa6ASyhWX3Ld1hBSJCLuH7vkqitijQSDMCqxqcGIeHqx1vF+/zc
 qjvC6L7aqVkjLgyfhewA0EiKr2zSuAdumXEqkP05jXGMHOCVUTe6Mi8rkLNjyslhfQzO
 EkD69Jk36L/qkpBMstF0gI6k61fKKMjh6NrQ+u3D1Nq6nSF8Yz49qWMbBSGCmYIVJ+vx
 EwI4h16OTHjXMJRjBHBLmii5sNo5c9uhnYtNK+WBNDqrhAwvwhKrQOpHtYeI4oVI4Vaj
 tfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TwwxK3FbqgNRzq9cSbI+NO5X1AaMIOH6AUHYNp5pS0c=;
 fh=5Da6V1QLSAR2Opu1RwHe2xOwyhp2Iy8t/OL70bwIwWM=;
 b=fwn3xku5IeGkT9B5kwxv+Zdj8C7oKWlX6kJMWpPTYkHmHACYKvBR7gWR4e3NjpwIU0
 qn1MHXvYFLWLgx6aghmc8lSz/cHb8tnVSJpvL74S5CNk3VBE70GUl14RyA/vMCTnMTwb
 xoyF6MCqGUK96fSwjE89dOECBfK2pFPZUEU0DW0Jdim7GQ+GYQSbwsWdMh0PcevZwOLE
 q4MhfX0CMJ4KuwX1kPcBH9ZENg0egbte420mBdev85LdZAAd5wT0cxZaOUA2ZOQuS4+F
 VxA8Y51921juNXNHsUqic3w5o8KOtdfmddqQZAXcNkP/FC8LSgy8xs1ZdvnE8eA1FCRG
 /srg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781020812; x=1781625612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TwwxK3FbqgNRzq9cSbI+NO5X1AaMIOH6AUHYNp5pS0c=;
 b=btAnSso5POCSoY4yIiQJnib7tkbl2dtjrXveZE9tu9PWGJjCn58/kZsNVZZ7ht1jt5
 iYiClrzWQt3gzV3uoRBBHAFe8tF39GR9RLnCWa9nry++3m2qkLWLYZ29IlDGq7ehFf1h
 KFpZ8wrsV22HVu7cnslKxanbyOAt4Mnp/Y1FPy1x4Phjfv/2VxHUj8MPP7704lvaU0ta
 Ahh0EQgoURxyIUt91cIvyFCiehPGnZyejVzxybsLTIT5cRKlzgNJuHzh7320PYIumd8W
 OWOoRLQIvm+ZHugVmJIB4cZKGTyEqtgR58B8TmGRsPJyyQgrUBhBbSDl+UojujwKOz3C
 r28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020812; x=1781625612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwwxK3FbqgNRzq9cSbI+NO5X1AaMIOH6AUHYNp5pS0c=;
 b=BHuyeDK+fsZ5YwjcaNbBCA+1iL9wg4Nqymwrmblr7crkhrKXUVGrWbMIUQuvT7qKax
 E3Z7pwoecIOec+K3SYyaQx0fca3YXvyhblv/5vKuoeqCZ8gO0SK6PQcbRr2uxEdCP9KW
 KikBIce5qjxVxGjJdvPHBxjnw7izMF796hY99dSGRFv6T+uTveRpg5nTQ0/VhWg6X282
 vqyD6b13DUb0yhBmM2Vndkiev6mPg6CfTETLZ9hrgFZgpPHiJgk153xzRKmNvlQyeGYX
 UTGSWy6J0w+wlOaQOhIcix1LDvkolAwaPOS/+z8ejsHwZpqjh61OsT61g6/oMhQFYm0B
 YMCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ807sXD6fh6aUyskXYmpxvzyQo3XFZ67N2WsXqbxSUmD/XDONOzB28thszZHtLKLCfzW1OELoVMzJBM@nongnu.org
X-Gm-Message-State: AOJu0YzfQqQQ/Rt5PFZepP2wI+fuGaUjs4CblHR2UkB18VAOMovGpO8V
 3ttrGvk93mGzWZDPvtEh8JPE5YZ0eoDlyyAQefKNJssrDCj+XtLFce63z4hxTPzp8YTKQrPB4+3
 3BLhpSRStfeJu7kX+Zz2oDO0K/K0DtI76FO7+gEef
X-Gm-Gg: Acq92OHQ6VQLACQ4VYO1Rn2RZywcuEsmEzadEhtfz29v5kYwDASRm3qhC5bVpXd89Fo
 buxgIQEcpL7DEFOtxQyn4slWqU7DI9+A153Dd5+g3mUTisB4kJYMDZCEFduF/MXxOFHGHULqkiK
 8R177I4NJqZKPuHqTAdHnX4F+QCZmtPbvNr5oG45LgE9ViZSRc1bPqJMBHsrbFRk3aHC/kub4P1
 JB5qD6r7O2fK5EWfEein2I8uW9m8Z9ySfwSWP2V7fkwQ0kYPbG2GQ0LrTditjulx61BGADfVeMi
 NW9bCsgY41yi3N5VB72g5O11Qbtvp/boMfHYqOqNhfrArK88qA==
X-Received: by 2002:a05:622a:1b03:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-5179826672fmr38760001cf.15.1781020807491; Tue, 09 Jun 2026
 09:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260609105626.1038690-1-thuth@redhat.com>
 <CAFEAcA9O6b02VMuto8VzaEsVi3zTqNtQKG_RcMaPnNdPXGUBhw@mail.gmail.com>
 <CAMvPwGpvpHD+Sx-HZR4FFMJB+W8Rk8LoU0256Q=vwKAdC96HSQ@mail.gmail.com>
 <CAFEAcA9N_O7RZRU+SPTfB_ePasjVZvUsFPhndfQDuHgQ+4Q-5A@mail.gmail.com>
 <CAMvPwGpzAcDxeqSvQmOjzkQn6T91CAmTO31bNs0wmSMqQKG=Qg@mail.gmail.com>
In-Reply-To: <CAMvPwGpzAcDxeqSvQmOjzkQn6T91CAmTO31bNs0wmSMqQKG=Qg@mail.gmail.com>
From: Titus Rwantare <titusr@google.com>
Date: Tue, 9 Jun 2026 08:59:26 -0700
X-Gm-Features: AVVi8CfSCk7cpvbPjjjcictp7Y5ynWYI7fOzBypElkdPKdJ7m307ZuXjj3z5Npc
Message-ID: <CAMvPwGrnh9-UMv5919bLXLF8oLcyTa=coTdqh+1ALNvCKLmOJQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting
 too many bytes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=titusr@google.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

oops, the patch series that fixes this needs to be upstreamed.

-Titus

