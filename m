Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B88EC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMIU-0000Ix-JP; Tue, 03 Mar 2026 04:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMIR-0000Im-ME
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:44:07 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMIQ-00086i-4A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:44:07 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so4789206d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:44:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531045; cv=none;
 d=google.com; s=arc-20240605;
 b=QZeAvBRVrl6ZrZgY7SCiHf7jV5z6Zz52cL7TF7CJw1MyQj3JuDuAAKA1tuM6PlBAdf
 Trp+daMj137ZlGkYUbwL5hbIK2glM6UunBZLi93WpTl4yjBBfZXCWxNVZ7r52BrPAyId
 dMu8J5SewoqoNclc0cFzL8kOUgh373mfvPt8JrdiXhiyYynjErJLrsDGBWH5xUQV4CPy
 Xy4hwX5owxbT7d5e87ZskcRfiqEro4oNMvxQkqTkUn7xbYuEmv8yG6r8fiajXv36C+EO
 HAN22W/Jq10+YFDsN8gEUvsrKIRDauDefddqIy9/Zz2NWY2knQHvC6PtV3IMSnpjsgw7
 Lxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j55or0Pb5Ij+55T7oxDHOYLL8N3t3fm5NXOQe9C7JvU=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=b5c/GJlWKChaf+lIdfhlsT0UKnNXLYntnZF7aPjsMx/3Z20lV0PwAxOCQgzxyrzGVd
 6pIpwTqBCRr+oBHmQnuCxxU7eZGPyawS0K8QYrEVJCQo3qHnNkbelng1ucWa98EV9hvX
 pn5589i4W8hAZdhNzq1+6/uYlx1NY7B/Me6qCHiJUCc1rs6lVgtjRBeSAKeA/1PUgFkd
 QwECcIhtHnp2XxolTD0SaYPlZfzR34DlqxeqQ70cjnqr1J4ZiZISbNqNS61IlVKOOn/4
 1QDwkYNdXUSgZKL6JECzXECJsmlpUZXGhulga8ByMEo5TmPZciFjUQBO64T0q98Qx9DG
 5LNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531045; x=1773135845; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j55or0Pb5Ij+55T7oxDHOYLL8N3t3fm5NXOQe9C7JvU=;
 b=v/HCXNO/eY7+s/+XCsSmfvaPHZphmdHofT21d7NeDT4wuwd2k/wsTKGUH78Lz51IQj
 t3dYy1K1BVFgs0aiiReoiO0SY/dmtRjiEscwER3V7fKrJ/oivpVQmLcypXzUb3Wvy9D/
 wiR9dD/pOgmGaG9zIGUSKTQrI+qHBl9Bhh2/p3QuNRkDeELVWd1XgS9atgD9aImMkNxS
 0TImXRGostLNf/wA0+NPd4dMzu7wAP04rzsHLkv+U/u2tfeI6AQbacb93M75DTUWwp86
 noOoQnpHX5odSjsf2FYwor/6jYI4Av3zZaECwhkfW2jEo3HDd2rElhPvY8C8mSQNIHXK
 68DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531045; x=1773135845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j55or0Pb5Ij+55T7oxDHOYLL8N3t3fm5NXOQe9C7JvU=;
 b=JKk5DZ8V7x0e4DBFxcALU2yf+T0u45haX3XrEPQhw7dCTIZBNW34Ah48AO6bzVWjcm
 7X7aQ+7TmXnMs3xJAeZf/WkfGZ6ijuHwoUmXZJDy9CDvourWAiCKyjTKjNODEbxjjyqp
 IEfQp6xlzaSNqGxPyOiB3bkfEtvqftKNuvF0K2HW93PgWTCcW0dAMfZhTuUb68nx3Ixp
 tce/CiPwDyrFgsr89yzPTWqgZbWz0aoTAbJkXkCGIO5lx9r6Tu3o2tb+mrp6Fvqb3OA2
 BqnQUEQi/7zJPUuGddPbXFY51G3Swm0hgl++u/cBSkINZxe01ULphbO796EwFTl4ZeWt
 CEMQ==
X-Gm-Message-State: AOJu0YyCbL56swg3eNGnyseHNjzQNKHni00fPNUBTO4IzSEmDVBk85w8
 Hlc8m19ABWqIrqo6rPX2+am+2CHRSSwBSPGSXa0FZAlrtceKj6rFkpLyVI/n/lx70gTt+pAaiIE
 xRgoNFpqt/Lr7AoPu0YBP8ElDhWtbPVCce0Uau4in/J9ib9eMDZLH
X-Gm-Gg: ATEYQzx+Il7S86r+T0lWtFCYtj7OysdLuNJwmLpv/LElfjwGdVOodyKSxnrRfEu0/NH
 D3b9iF6dvbGhntJW1T+MqdKVZBmy2Q4dtSIn1Z+D8Xuxt1S4LZI7mNvDV+QC45EVOFacPOgxVDe
 rIWfF5xfX3YoMtyPuAzGYrdbfExgCFWZFREBo/9klVYOU7+94F7w/dDeZOmosK2HTX9kid/AH3X
 swN23Ulo9o1VkQg4rgfYxQ10/cj1EaLvfwSTt9/v2uBLgq8XPxwKZn3u2Qpji0xrzGTvOaZH4tC
 eEy4RnCQ6R13KnCJthIfodiiOk3kWvgVPallqKYLZ7ym6ESGBvbHTjzLM/RC8AFYYX2DFnMupZ6
 gjA==
X-Received: by 2002:a53:b003:0:b0:64a:e781:891f with SMTP id
 956f58d0204a3-64cc20e4c38mr8603550d50.28.1772531044978; Tue, 03 Mar 2026
 01:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20260302123413.274700-1-thuth@redhat.com>
In-Reply-To: <20260302123413.274700-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:43:53 +0000
X-Gm-Features: AaiRm50dPtGvitO-oiAz1PuCYhJVW04_wPtg-XP5Hl1opzWdKpgTkD5McaQtvEI
Message-ID: <CAFEAcA_iytyep8dqOx8A9GWrrRRT6PeTicO1yQ1fBr9re483xw@mail.gmail.com>
Subject: Re: [PULL 00/10] microblazeel removal, improved docker detection, etc.
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 2 Mar 2026 at 12:34, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:
>
>   Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-02
>
> for you to fetch changes up to 424b4b82d53ac26ca3e991b1f85de225cda707ba:
>
>   gitlab: ensure docker output is always displayed in CI (2026-03-02 09:48:10 +0100)
>
> ----------------------------------------------------------------
> * Remove qemu-system-microblazeel (qemu-system-microblaze can be used instead)
> * Improve detection of the docker/podman binary
> * Prevent a null pointer dereference during zpci hot unplug
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

