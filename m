Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8B3C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64wv-0007MM-RZ; Mon, 14 Sep 2026 07:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64wW-0007DS-HR
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:33:53 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64wU-00009s-D7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:33:47 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e56a1fe3fso1393022d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 04:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789385625; cv=none;
 d=google.com; s=arc-20260327;
 b=RmSbKIWwh6O1JlYWfYpI+LCetk4HPS2qtUzB6vxy9HThpP7Pk/YwfY49gnHFwtiG0E
 hOxFjwbuho3FnBKzf8mJwaacNMi9qrxt2f7DXrKpmGw/JyP1qML3G2ExpfzAWAeVm8nb
 ALN/HiU5sysGq6FBtNLsHAPflvtPITRXo9J93ITTeeb7u0pyp6p/0XF7UBxwaQ1rRDh2
 YtTpk7C7p6gUcrAeriuPDvo5MP+ZkNBgnY4yIZWZePirfJB7o2ZRoqCyd6gxPlhrYiRu
 NWc4dK3GzrS7+jj/+C4RImYu+CnoYswWB2LkVmVvmPJFmUahh9NaOmY1oxZZrrTAsSHP
 4hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IX/J89ui+4pqIuEUdfE+impabENncLUrNUGlewxusXE=;
 fh=I4+9jBsawlEC6VYtYQWWbwhwDHCjIcQfIwimnV5OqlQ=;
 b=h+I1NeCJn1m43Eajn9dzeppJGJRu3wGPN2/AkzZKu1p6z+iFiDopuDWv9gWCpDc+Th
 8ibbce/IMlIYE76nQjEGvtb5v4TUdekrhCc+8v+VR6fkW2/tR2rozJML6J8ARvi+ySIa
 JwwLOsI9NQABozDcKwP4GWtsP5CHPqj+6O8+NH6lOnUVjo+n5qWahXSe1rI76aNUSh7a
 7ZZ4AHcJe6rO9LdTkGcP29H5MhSw4sjM/EQnyC9boL5oN6mHx8D6VupQkLK6yA0ubiMG
 DMOW39QDh2iWrySRkkhPayZvs6ZOnX/I8JrFu/NSLmJHIbMVFnkM5Bsin/VUHgwvHk+d
 MIzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789385625; x=1789990425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IX/J89ui+4pqIuEUdfE+impabENncLUrNUGlewxusXE=;
 b=sxUJue8S8MgO561l7X18gxeNn+HhfmGwWMXTrHW5h7N1wwe6pBJ9Xj2wv5sfI+txTC
 JPwK4gSvPXcv4rOkWGtZ7rd2skOBADAV8ibXGd9fZ5I6Pa8E/l34bxpG1MEqn7OTN84B
 ErvEwd8mMNSi6JmYP24ruw5Tk+vEPW8X6AT7AU5GwDa3pY/JkFKBYaEcx4Y/bHcgMH0b
 SDS7Zb7zezMJXAZGxDv3Rfmg/2QnLFGfPiIfoHZcEZpGLSS/UaHxdVrPI/8p5bwbSBVw
 qcsYIr6giZnv13s1tr/KTc0UIEVTmaGAskpm2og2+rGkswlgriLIsqMhMlrm7Q8Vj2Qb
 8q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789385625; x=1789990425;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IX/J89ui+4pqIuEUdfE+impabENncLUrNUGlewxusXE=;
 b=MpFXlsB5j7u4vSvGYZaw/YZNgVkK8Xscas/Brl6ET2XlxoI7x7Y3xF//f9/JM0mH7Y
 RoPvAl1owHLjrA5QoqNW9k5fPS63P2aTeAioYL07Y2UIIs6UCcxh+EH5khfCwn8mpmym
 bADjP7CsUe5xNbjNn7z/D2X1ocEzr+N3Ywq25hxOXp4JfHaijuXalkXwclSDLWDmpkBN
 E7U1R94UC3PSoSULVEc+ZptS+SGvDLkQD3c0hGvI1w7Q6S0FewLI3KHw5/UfoVXC4hKo
 EepnEAyOlu3zeKnmyuRvEQB/a+GnM1e5Fdi5HqlO261OGAqc72JHnlWI50A9r0ieutzC
 E+UA==
X-Gm-Message-State: AFuF++k4iVuDHfae44YtvjT5K6paMqhudasf0m+gxw2EqH/HrQdIBATa
 +QTmmrEd3WZhS0B933/GpEWf4ALc63C6Cnv0G2l1oIytVtTXl8a1UJu6mI5tnIR6B3bVP6EBhJj
 IxwPgsh9nwZ/IW7JBjNj8t/Fjqnto/dhM/V1S9nwAnA==
X-Gm-Gg: AYBFou1nOH8a7ZMfL2tdGBtd/fJt7FzINIP2fyE5dQVovds5BpJ1gChA0ZoAnYgX/I5
 pYEbDJ7QM/PxYGnyFr0Sih4czfz8wBGX6pG7VDgcPxkqR7FOU8x8KvekEvM7lb9VsFaVmmwy5xU
 LzfuZk7CJDL1rsKQnVFpDPDfQfoTnGXdpe+/3ahkMAu+9Kxvv6XS3qwVZPV5E+8riWCydR8mu2L
 1xlTI4gCgoaGRZ9noVQAUsDeRrBpOweoE2mqQdHJKkOzig9KQR5/HrfQgVSzN3b6xpgsr7o0GRl
 V7nl7cuSCCq0XixOPh6UvsD4zitQHndPGYLeGX1MDdmu9O0zT6fQwy4soLvJ7P1jlmUVEdLzw46
 EPMBTdBrCbIdZqI2RaDkQnWPE3zDMk7ywge3rd5/a
X-Received: by 2002:a05:690e:454e:20b0:671:214:30a6 with SMTP id
 956f58d0204a3-6714e1a2387mr242294d50.94.1789385624534; Mon, 14 Sep 2026
 04:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-6-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-6-2b21e63974f3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 12:33:33 +0100
X-Gm-Features: AcwNN1U7ac5_-fDMC6KnSxbCu8IVhcDryy5hxbN-tn5BJ-jkcnxG8dKLJMTKdXA
Message-ID: <CAFEAcA_Ki-Rt2S8=db+z1zfCNpeRXXqMHtiG7aKCLWPyKYDfYw@mail.gmail.com>
Subject: Re: [PATCH 6/9] tests/launchupdate-test: fix fw_cfg leak
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 6 Sept 2026 at 09:54, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/launchupdate-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-t=
est.c
> index 12a09079ae91..beec902caa6a 100644
> --- a/tests/qtest/launchupdate-test.c
> +++ b/tests/qtest/launchupdate-test.c
> @@ -149,6 +149,7 @@ static void check_error(void)
>      /* should fail with LOAD_FAIL since it was not IGVM format */
>      g_assert_cmpint(status, =3D=3D, VM_LAUNCHUPDATE_LOAD_FAIL);
>
> +    pc_fw_cfg_uninit(fw_cfg);
>  }
>
>  static int64_t get_image_size(const char *filename)
>
> --
> 2.55.0.543.g5ebe2ebe4ea8


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

