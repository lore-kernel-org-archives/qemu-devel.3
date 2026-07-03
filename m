Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308FC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbVh-0000rg-Dm; Fri, 03 Jul 2026 06:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfbVf-0000rU-8M
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:52:39 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfbVd-00018N-Mz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:52:38 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664b84118d5so646221d50.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783075956; cv=none;
 d=google.com; s=arc-20260327;
 b=mwfMNdblOYnuuz5s69Oe4HIFmrXM/4K9y263T6RuATEw1k7uMBUjmHuX34KiAQAF1n
 jqkm6VTq5UXmqTIWbzmF4N+thxrqHZhWXSnXareMfSef5p96P0ceKx5eyBUc06ZkVrLX
 /CUyJIV90mrVTsbozFQPgCvftVJ6x1fRGmhi/F9k4wanCC6ZRAlRoQ77QijJFECWqErO
 z3CDwryVgstLb+tj9jA3UF9/ZMKVeLVfgR2zIU5NCfEZnUPj4dO3BxbZUwogi8LiHbXP
 BpB5sP8ugIW+fb7lk9JN8tLwtWoMMgz9KBVlHfY3UauyjT/E1sE35ogdXsWLR31T9my6
 CiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9tPQFCyOd8QdZ7daFE41fjQIZ2tUpYyb/1Lyhq256+I=;
 fh=7R/RZGD+m7OAV6ynsYAfWZ1IG1hYR0cKwZ0GYuuX0rE=;
 b=WbNzWUQ5bJ5m0hXwj6ACR+y5ryj2qFeP9J6X7ruiaNgAJG/Cv09EFq83KBgArybGIf
 S1mj4B1tSBRtjxyXvN3b/60wNUdGE9cQTVIqn5ZOVM5ELCpd0y42tRiedQV2qvqBc2/4
 7PCPHpImvZrRk8EIdClZkS0aUb0XZwfOckNiNO+fHVkAaMZpOdWvjV5qohe2Hc0/3SYt
 JMxBjrNrIWCqLtyqAT3BOI843ekZw7aO/TEOKOr0wEmYfD/rkJXcMeQECj+xXkOGEUYv
 HgMUaM/jJLcFoYCkAAI+40Kd3sngYyxhBbAmuyMly0/QV/hHbcGd1G5QutgN4M5Tj/hR
 Ec2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783075956; x=1783680756; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9tPQFCyOd8QdZ7daFE41fjQIZ2tUpYyb/1Lyhq256+I=;
 b=p1Ro8tUi59DCd75fAP1z/zksl+EtpD/7OXg1m2EAageBrNbSUMloNghZ2ymNXIQPLi
 AO0PwlTQdwLOzIz6kL+oyqVY9Fxho7o/YzUVUI4eO5M6nOm4cO2sXHWlrIkE1NR5s4ID
 o/5Y3EDRSTb8L545c3H4EgRnHn6WsDj42vbiaX7qchv4+nQmkc4D+N9hih2rZaLeT56r
 I8JjuY0TLWptw8y13qDafpSj8S8u6p7wUvW5hu/V0HduTTdXWoSPvWod4aNUJ/nQU1Yc
 7/sQhKfnDTE2cMk3FtVONysp+UKB5KHfmmGIi7liyw2FV8w1TuKKMs9zAlu5pohP40Uc
 DJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075956; x=1783680756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tPQFCyOd8QdZ7daFE41fjQIZ2tUpYyb/1Lyhq256+I=;
 b=kboRd+nG1L+FeDdzG2wR/5CtbLJvDN7tYZjeOw9d9JEIJQYyWqCU2mxPvFKtffBme7
 CnyP1YVU8lgFXawgrUFFK3fGbx0wH8U8a1uPVo+Ptr1KOnjLo1ribP/ohVbHsYM76BZA
 c1AUVFKoWGW4yNh1CYxnfhSMXp8RORm2MIm1ax6MqGnM0YtZGQyaT5MdW4t8Wgb0Pzhx
 otEz6JVovah4u0dfcdYhzLIJ61QoNxTHnmbbrB5JdQoiqSsWEEQq0A66enVMZ1feMdkG
 TR/RdWrDMXcpwd2/fcVyVgIyF6DIjCPR15P9Y83BM9doI1xYbq5tQ752CrKdbAdVGPlQ
 6wfQ==
X-Gm-Message-State: AOJu0YzRykAsd1+fG4rUZCvZSYdeZeLdtC25yVJQiIeT7Q87lpXVWBoz
 uUk6OAY38nxvJ8CWTdkU+oI4spwL+L4b7uQctYNTKwlX8F6iNs2EXvBJg61NQSveRhgqjmgoeFL
 Xl45gKcyRUgtL8SdQckll+E74Kdf29Y6tT8KSFy2kuA==
X-Gm-Gg: AfdE7cn6W2/o4fkbVknZg5ye0rH2iz5zvZtwFZtdXm3h5aVL/T54UhdGKdjSHQjLNhL
 8ntR3VZIuHry8uDAWzOiMs+Ma4dagf/25ms2KIq9kVccUoyf0INHJprAvW9SQfU5/IXVYem82R/
 eM6lUJKN6g+0JrXJ2yEVU4hQW6Rbj2OzFr9Lll2iteBGZZ2WNUrUsoAwjwnaWWdEJrjp4dIET0f
 dRfWguCGUx7D20zwA0GWaSL9eUlvU+ytnn3aNFhIgxtL2uJ2M0ZhBpGBJpfi+LZ/2HmPdIvRl4D
 rQCIu74UnSLqhhRCTV/r67L5/0cl63IBysqq5zHTdm1bILpKLyS2gJeW
X-Received: by 2002:a05:690e:14c4:b0:664:c9d5:f8b1 with SMTP id
 956f58d0204a3-66521bb09ebmr8847231d50.71.1783075955938; Fri, 03 Jul 2026
 03:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e.1746438650.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 11:52:24 +0100
X-Gm-Features: AVVi8Cd3r8a643GnB1B8q8PFJiBDToKEutCrqgwpXDBdJkgdn4zrDOq5y6Eu1oA
Message-ID: <CAFEAcA9h2QXi=9tTUpzSHVx8p+ZxtZYxFNiCQUHOu68W15buCQ@mail.gmail.com>
Subject: Re: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 5 May 2025 at 10:54, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> From: Greg Kurz <groug@kaod.org>
>
> Factor out duplicated code to a single helper. More users to come.

Hi; Coverity complains about the callsites of this new
helper (CID 1660923, 1660924, 1660925):

> +static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> +{
> +    if (fid_type == P9_FID_DIR) {
> +        return dirfd(fs->dir.stream);
> +    } else {
> +        return fs->fd;
> +    }
> +}

dirfd() can fail and return -1, so this function is "returns a
file descriptor, or -1 on error"...

> +
>  static int local_fstat(FsContext *fs_ctx, int fid_type,
>                         V9fsFidOpenState *fs, struct stat *stbuf)
>  {
> -    int err, fd;
> -
> -    if (fid_type == P9_FID_DIR) {
> -        fd = dirfd(fs->dir.stream);
> -    } else {
> -        fd = fs->fd;
> -    }
> +    int err, fd = local_fid_fd(fid_type, fs);
>
>      err = fstat(fd, stbuf);

...but the callsites don't check for error, and instead can
feed -1 into fstat() or other functions, which isn't a valid
filedescriptor.

thanks
-- PMM

