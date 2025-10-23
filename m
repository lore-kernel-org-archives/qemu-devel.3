Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C2CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBxRn-0001C9-SZ; Thu, 23 Oct 2025 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBxRm-0001Bq-GG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:41:50 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBxRk-0003xZ-La
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:41:50 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-785d3a5f641so6181427b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761234107; x=1761838907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aNJ/mzjc8q3KYfYFMCVDCe4wOgwKkvdCR5IVhz5kulo=;
 b=wpMMTw/ct5vEubr0WzSUwtpMUKUdqiMP51JFN5eO5yVrT8ytJlpcSbMs0ueq5CNfBY
 uRC9EJ1+va+j6rSHTGz4Deza+eFOvVywkK2fpw+T4y2FbxG5qzXm7/zI3D/Gz7W0TSg+
 sqnNE6HSrqHt9sUkvKnMSdPoRXf+kz++jxT7QOWso9Qzf+biEcQJ9k2KGZZuFtJwUjSf
 U7Sm/0EZzmpdMfGXdN3EF5jvTEYpBLJIlCAf2uK5MO3dDEFckFeN63Kj1aI76E61BcG2
 VSnlmETrHPvPvjTPErG5uGnrxDZ4FppCx2EdHl90YCvd8T5xu23WiedLHfWye1pk7q6n
 63XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234107; x=1761838907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNJ/mzjc8q3KYfYFMCVDCe4wOgwKkvdCR5IVhz5kulo=;
 b=j1Sg+T9AdIBCcsBjHf58GOeQlcz9VKxQMtHow7jfF4BOoP6rgV79aF48sy/W/7O8MR
 kxvlyiAPK4wLV93rDIL1RANkeFXRf3BN0pnxYhFTUSogkeYfcbiNBJAd7M+dOsHVdHwG
 uOk2sbBWPsIEC2OCrMXucyEl0wvvwcOoQZEwpzKSfnCq0YccCrJuYsnGfTC8o/qyYoJy
 Pl1MyDANrjSYh0WzZN/+DHMP6FmPRvZ1X0Mzwv7L2KHhNPWjK+edOcV8m8V7N01f0cUG
 C0MQ2tGEMsZcfjiDoWcgAowMLpeBM2IcpQt6ucrjpSRgl53vTefbEgZmoZuuiXizn39g
 Z4vA==
X-Gm-Message-State: AOJu0Yz5bdKe1hNXODYh9RUSKLsnvHTCze/yVoAfXmKis/EgixJfPAgG
 +gzrKZdAMPVCYzVtBNNTnL8Z+E2kkWSn4bIpeiR6Zzjhr1LAbKaX0g+7nit+43hw0QYJ8zNnTxH
 lc5Mqhe/CbVRumr52nxkLD0X7Ij9dQzUr3L/epOElvA==
X-Gm-Gg: ASbGncvFUHJHCVZz+1FIUvLBax4S2xyCRdZe1biGDjHHOuEkjuXoOafg3yvtX0kixUv
 vmGiEocnc31bTGc6oNlOm35WCLqP8rL9dgX7KbgNFp6kwTny+ASTkBJCMxJENxy7Y3LhA5M2anc
 e5BqZkmoj3TBHcS5cF56gkwDfcNqnVQpjDgXwIK29v+bk1J9jKFGpuYbVehJ0QCTwwfq+S6+7VQ
 afWOKpMIxUWaleYELwcSuRxhhxgjAXwLw0EJcFZ4JQuoorPiXeLJVpxitRfdQ==
X-Google-Smtp-Source: AGHT+IEXN92PMEzx8kpmVjcc1OOIyapLk81HclIYghHn6UE3s6sMCtY+TyMuBZBYxY+0Bhj20wctsKLy8DEc/l2gdVo=
X-Received: by 2002:a05:690c:a91:b0:785:d173:7d0f with SMTP id
 00721157ae682-785d17383afmr18495617b3.52.1761234107008; Thu, 23 Oct 2025
 08:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-41-peterx@redhat.com>
In-Reply-To: <20251003153948.1304776-41-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 16:41:35 +0100
X-Gm-Features: AS18NWA5Ww0np3mNgpztpoHvre6w2BG3eGaVJEEdtWdY30X4G9c13B8ySs9KQhg
Message-ID: <CAFEAcA9ecytcq3cUsYZiskv_hSDR4iO+iccbVYyRZgHaHMvUuw@mail.gmail.com>
Subject: Re: [PULL 40/45] migration: cpr-exec-command parameter
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
>
> From: Steve Sistare <steven.sistare@oracle.com>
>
> Create the cpr-exec-command migration parameter, defined as a list of
> strings.  It will be used for cpr-exec migration mode in a subsequent
> patch, and contains forward references to cpr-exec mode in the qapi
> doc.
>
> No functional change, except that cpr-exec-command is shown by the
> 'info migrate' command.

Hi; I was doing a 'git grep' for accidental misuses
of g_autofree on a char** (which will free only the
top level array, not the strings it points to), and
the usage in this commit confused me for a bit:

> +    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> +        g_autofree char **strv = NULL;

g_shell_parse_argv() documents that we should free the
vector with g_strfreev(), but g_autofree will only
g_free() it. So this looks like a bug, but...

> +        g_autoptr(GError) gerr = NULL;
> +        strList **tail = &p->cpr_exec_command;
> +
> +        if (!g_shell_parse_argv(valuestr, NULL, &strv, &gerr)) {
> +            error_setg(&err, "%s", gerr->message);
> +            break;
> +        }
> +        for (int i = 0; strv[i]; i++) {
> +            QAPI_LIST_APPEND(tail, strv[i]);

...we copy out the pointers to the individual
strings here, and QAPI_LIST_APPEND() doesn't do a
string copy, so it's correct that we don't g_strfreev()
the char**.

Do you think it's worth a brief comment saying why
g_autofree is correct here, or is it obvious enough
without ?

> +        }
> +        p->has_cpr_exec_command = true;
> +        break;
> +    }

thanks
-- PMM

