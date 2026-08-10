Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F37C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtPdr-0007S1-0r; Mon, 10 Aug 2026 09:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtPdp-0007Rn-0H
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 09:02:09 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtPdn-0000wF-9J
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 09:02:08 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81ecf499af9so24668647b3.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 06:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366926; cv=none;
 d=google.com; s=arc-20260327;
 b=dtA/mNrAbQ1aBDvG8fcwGUC7CxQQ/cPfVFKAqVuTYrkFCmugshe94Gf6sBfVSTRtwH
 R5pkkqBuhMbEPSbFpdUwEK5TS0y1Jyl83MgYxDhxd8TCw/3BbvuV/3YpWSFuid1W+lfm
 h5eDtY4NG1hjgFdm/61xb3DAKiqJEpAFu5uxkl/cdFBCeYWRpD+56OG2tBqRP8ABRErA
 7GguFXkXDOnkvF3uXqLjDp6aqJyV1fUWgRBJmxUCyrfIO91LzKTYnPUrTixI6LI2XB+4
 jFbdfMWZLlz7Q+PiyAKBdRvOOBw4vxCa77hTn3xbYjLU/q0yb+kPBLUZCMyf02k0m0g2
 5YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oeraAWTgUZDMHofNY/V26h6vlUOfgRGJVhvKV/S6ZOU=;
 fh=7FzEi/2LFrewGH2MJzBtQfwp2vNgslaa5OqjoXzw9FM=;
 b=i144Almh7Ee+FMeyoFm2u3VOrsSSwS50TTnezeia6r8WaIq0gsY2hjPvbzr0j8JBsP
 gTSpfSG4xAugIwkoTM6OXYphY7kIu3mJQr9j3XZz8D3FiGwt9phYEkPy91pFLLBtzaxe
 VQrP4YSiadf3cQv43Ciwfgf53fZOUd/Zw2gMeZg1d/I0/vLtbxGNqCUufGhKcYfFYuBh
 p+6fGcj1Lbv1bZ0yFRwsN+NXSFlzFNm53VOh4sHGGgHHC1G+RtDntFAjsf4BTIRLJqD1
 q8zv1CJBdEvN9x0zkoudkeoB45EErWalVCF06VhOCIt8jnXnOlZTxqRJT5tHdqowSpsz
 ETTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786366926; x=1786971726; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oeraAWTgUZDMHofNY/V26h6vlUOfgRGJVhvKV/S6ZOU=;
 b=rqRMTWZcEm8FKWbuafdiUd73xxQpW0VHk+Sdh4qWE+dcCTwYuViEV0uzvs8/MF4N26
 Zbi0xZoLm9+nmJzyDZBHu5LsrEGFwmD23Rvw/8QFEhvEVvjBeZHKd/4FdiDa8W6JjN7v
 LQdWUXa7LT3Giul1ivs7b53orRrKSyNzQAtU3mAFDurEv2n3NK3ksT/VK4sIEsZnLbQk
 gGAE9fUzEILjkn9Sqh9FtaUovpPn0CKX2u0Q80YGjC+wB5HP1pj2TeCWsVIv8GQaW1Gs
 5vCBy4QNwtV9OVGJBFwB6bbNakxLTPVd9+QjPzlNgEJh1D7tKIem8YJVmWs8IMFuhDh9
 7jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786366926; x=1786971726;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oeraAWTgUZDMHofNY/V26h6vlUOfgRGJVhvKV/S6ZOU=;
 b=rjAEes0WJ2KDtdO0mcg6ybN6A3BZ5q/a7ak7JTWk3cLMAPl8DZ+llb9coqhu2z+RNR
 7IUrIPCpjOeuANa385H5zTsKgtX4AUe0SElSViMql8euTeL8KMByo+2Yq6G72lK77Xji
 NhkOez3ec4yRgMpFAVbVPOR/4MFpujZ/ndh5itoouLn7xSreyqEolEd+uijjFcxk7lrA
 YAE80z/FG86w3b2x0f00rJzCHT5ix42HIuTcccQrvF1DzkiJRT1yhaFmmISwxf1ynvPC
 7AH251p9gdrDLBI42Xiu0ZxP7ZtUFdBucaTOXUbeqPGppSMIcK8ZLZoJyQRlY+kn7jRx
 zWgQ==
X-Gm-Message-State: AOJu0YzJg/sqVhmuLMj5XIXO22Iiz5fqbQY4C6RcbF7OvNILYqU8cHbk
 zRQOs2nQMfzZEK4O3Te2w5oRRkshimWQiXUreR+WH3Eg/7wuREb1QqgG4tKY0zzqTLSOlGx1UQd
 umhf8XeCDS3H3NCBXyIc5BoKhm83aQMCkYa/a5LBAfQ==
X-Gm-Gg: AR+sD117Y9F3nkLJdr0g9cLBUaabqP5tph2MMd9vMbZjEAMFIShryyDTyDBc54w5nHg
 aEd2/IrGdEo3yZTmBUPD8BA3/OnmxIEsZlp8vglNS5bjvoAoAiMdXAqA0ot1noFitovewqgqrAs
 9DWvEM79Qha1B10a4JQaWylsp68MuGgRQak1wmdZvWG0WhwsaGQWPTbk9VDjjufxA3Wm2Ivu3L7
 LhXVm97Pkf5QMo3LMWqYotHUtW31SZ2bvGVeU60FWSZJyOZKWlf8sQTfjZrAxA+JmbiN5mVvzXi
 DzyhwunScNHqLcxAH5mPFiKV2hiyCqGXhcpyzjlrIPXVW89RD8CHbCezSmagdZ+Gahj7c6CXLr1
 Ashm3pfVWBVp2urz4x6lerABPhbcC
X-Received: by 2002:a05:690c:b12:b0:820:1069:f474 with SMTP id
 00721157ae682-82d27b09045mr6789707b3.10.1786366925106; Mon, 10 Aug 2026
 06:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260810104659.82320-1-kkostiuk@redhat.com>
In-Reply-To: <20260810104659.82320-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 14:01:53 +0100
X-Gm-Features: AUfX_mxTNMN6HbNGMY2t92DAB5Zu1VIYZWCk2qDJ4SaVA8F5g4s0rX7WWdWpMD8
Message-ID: <CAFEAcA_XugKUBOnfw4t1DKWYrE7B364HimYtBdLJ6CeEj1JW5A@mail.gmail.com>
Subject: Re: [PATCH v2] qga: Change effective user/group ID in guest-ssh-*
 commands
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 10 Aug 2026 at 11:47, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> SSH key for an existing local user, the agent (running as root) decides
> whether to create the user's .ssh directory with a symlink-following
> directory test, and then writes and chowns the authorized_keys file.
> A local unprivileged user who owns their home directory can pre-stage
> their .ssh directory (or the authorized_keys file) as a symbolic link
> so that, when the host or operator triggers a key add for that user,
> the root agent follows the link and transfers ownership of an arbitrary
> root-owned file or directory to the unprivileged user, who can then rewrite
> it to obtain root.
>
> Fixes: CVE-2026-12080
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
>
> v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com/
> v2 -> v1:
> Change effective user/group ID instead of checking for symlinks and
> changing ownership of the file.
>
> Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>



> @@ -135,6 +139,29 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>          return;
>      }
>
> +    euid = geteuid();
> +    egid = getegid();
> +#ifndef QGA_BUILD_UNIT_TEST
> +    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
> +    if (initgroups(p->pw_name, p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set group for user '%s'",
> +                         p->pw_name);
> +        return;
> +    }
> +#endif
> +    if (setegid(p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
> +                         p->pw_name);
> +        return;
> +    }
> +    if (seteuid(p->pw_uid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
> +                         p->pw_name);
> +        /* Ignore errors, we can't do anything in this case */
> +        unused_egid = setegid(egid);
> +        return;
> +    }
> +

This identical bit of logic appears in three different places in this
patch, plus we need to do the "clean it up" logic at every place we
could return from each of the three functions. (Incidentally I think
you've missed some of those in the remove function.)

I think it would be helpful to at least abstract out the duplicate logic
for setup and cleanup. Maybe we should also consider using the glib
autoptr-cleanup macros so that a set_privs_to_user() function can
return a struct that has the old euid/egid, and then the cleanup of
that struct enforces the "return to those IDs on function exit".

thanks
-- PMM

