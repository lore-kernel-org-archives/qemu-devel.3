Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1FACCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rJL-0004uW-At; Thu, 09 Oct 2025 10:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6rJJ-0004tK-Pu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:08:01 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6rJ9-0007wi-Fs
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:08:00 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6360397e8c7so1067243d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760018867; x=1760623667; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LBpmB0t2Abcl/tjUhtlIndO+4a/2qaqZnWQnYzhMc5U=;
 b=peDKhfEp37B97+i+PrgqULpXdtk+acfM7K2lwZRVxn91NWfviNccJWxK732q+7KWod
 rzA7R9aPvclqYT4spIWfGlVrwbYXlro2udVqZFakfBUGiUDpWOnS2TXhs5CTjUvFurJO
 dQHL2lWz9ln2FriUiKuAlLiOam3HsCAo3hIUT/eDmKwRapjaTlXUTBzJNt76tpCcYauI
 a5ud6VAgrFej587n5/U2POVQh4rJfHtLdD+yAAa1wL/3dca2+1ioLaRLIonkVMiTIhnu
 htWtKihP7yLR5IhpirO+4JdGZi7wuUhSKkjNLmycrSyRu2a8ctIt6lZb7ZjSprRftr+P
 R6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760018867; x=1760623667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LBpmB0t2Abcl/tjUhtlIndO+4a/2qaqZnWQnYzhMc5U=;
 b=doMg6gc91GTwBn7VOxILaEYvo9J/ix2a/+cP8tMU32/uuAX28glD8Fhcj+itdqgOMU
 PtUfybol+T2KpbH7lPsWuZVQN6LGp7eDE6eBFV7ArIu9KSxtRMnTfi0hzEahzE1zjnDV
 vhhN8DRI1j/UJpHJOzX+WzONOFYVb5rz/mxsRAVNU5x0iX4FifyUOZNQxOcTPY5Mh+np
 noGSt+SUP3lWXWVPWsrK/jFFK1wwQiaRLs4/zVRnxwXA1AsI05MdvwmnheZp5QdY2HEh
 bjzeCaNSE5oC37SyOvawjEgaAwP+55UHTlBoeFajzbWStFlv0rmm/Y2nXpbYCEVP6lB4
 i4Jg==
X-Gm-Message-State: AOJu0YxyOuKP09pL6iHXbceQPTSCYdYTZiyba56H0YGMGpYhBiPq/zNU
 28uE7yuwUMOxUpZQbxr7zS2jLnyblX29tckW5TKVTfX8IDy38wq+GSdpWJHhfk8AFYrEnYP6LC3
 Q4Zl0Pp7LaELdH1HkpQvzrLqWj834E3RDYkyJbMgD0Q==
X-Gm-Gg: ASbGnctbLGuudnFNZFxPwlhRjT8YUS62gvPZZX5rl3ROwTs2K7Vm1lTQp9eL+Mj4EUW
 8MdiGeqALJuXkH1ZPlL4O8O2s5SdUBswyd78y/P9VD3eZXwPtwy/eSxzkjk0VbC0Iozk7kt2cZC
 uZgBJmZ8DalXD19kAOIa1/cPXPAKHZ+zt8KVYbklSzOD0goFdLkIDeyB9bVTKZeZQs+NiI9axNT
 mbXxqlLbCq9AlT4HWjP+34FwcFDjamxGUZHOYILOXrxdAw=
X-Google-Smtp-Source: AGHT+IFUZRUXFXh0HnLfYTraSlVPcuabW3RqKHRgLOliiPP/qZCBLcK4QFnHiIqVxIFR5KM1q+tPKTX1lt5tZOt5OVg=
X-Received: by 2002:a53:b987:0:b0:636:18e6:258e with SMTP id
 956f58d0204a3-63ccb812e35mr5219746d50.2.1760018866996; Thu, 09 Oct 2025
 07:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251009140206.386249-1-john.levon@nutanix.com>
In-Reply-To: <20251009140206.386249-1-john.levon@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Oct 2025 15:07:35 +0100
X-Gm-Features: AS18NWDATbcZSyRNNmFTu1FZyyFbKRuJ9JJp9TUbwt7tgyBVKogH_9p7XLMCgzw
Message-ID: <CAFEAcA--cf9SO4sHgwTPDDCatUif2+X0_6S+GTuF4NGLkLpf=A@mail.gmail.com>
Subject: Re: [PATCH] docs/system/devices/vfio-user: fix formatting
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 9 Oct 2025 at 15:03, John Levon <john.levon@nutanix.com> wrote:
>
> The example QEMU argument was not rendering properly, as it was not
> indented.
>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>  docs/system/devices/vfio-user.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/devices/vfio-user.rst b/docs/system/devices/vfio-user.rst
> index b6dcaa5615..7c110b1644 100644
> --- a/docs/system/devices/vfio-user.rst
> +++ b/docs/system/devices/vfio-user.rst
> @@ -20,7 +20,7 @@ Presuming a suitable ``vfio-user`` server has opened a socket at
>
>  .. code-block:: console
>
> --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
> +  --device '{"driver": "vfio-user-pci","socket": {"path": "/tmp/vfio-user.sock", "type": "unix"}}'
>
>  See `libvfio-user <https://github.com/nutanix/libvfio-user/>`_ for further
>  information.

Cc: qemu-stable@nongnu.org
Fixes: c688cc165b ("docs: add vfio-user documentation")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

