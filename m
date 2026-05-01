Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA8FFF886F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIe7R-0000Ix-3I; Thu, 30 Apr 2026 23:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIe7K-0000Ie-DT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:00:38 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wIe7B-000500-Sz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:00:37 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65c305f381eso336957d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777604427; cv=none;
 d=google.com; s=arc-20240605;
 b=b2kma6RQ+fQmBiuZ/SpX7MA5TpnX62sipWMi2fp62UfVi907gRn9msAN7NyXcYnpyd
 PM7jRMT/GjUH8SIa6vLnq+H35KgFi1d9AvjJlWhImdI/qMP0c+JDWG//4vHRxYKG3fEL
 CZcVggEteTD1jI0lV19IQO3iL+vbzpFiz1VQYDQU4zYVKd9apjgaA8dupsI5dfZu7zY4
 4ESp8wr1rk+kBptMtCoXACdUGGiI91dITKAcb2+FQV9jrzXN4MJFWDeafzjrS/UNCOMI
 8f+fCtT7niYdINKMoV4WnCaQdCr1fhgqqnvmRiTNk76CK4Au6xAGRvkCknW/BqfqjCVT
 7/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8TVgbbpxkHLrusuF01rmOkHkuKzT9qf01Hq+f6K8dVk=;
 fh=xSF5Cn5IlcZ56sW4KBOds7v1bxJT9VYpErqAKX6G/rw=;
 b=QUmsbfMXQLvZ/0GEj/Uy0zeEN+bn6kBt9RUMO6yXD+kB37pLe0Maaat+Ga9AFsyQtH
 ppJUukNuTWMCGF8msm9q+KgLHN/18PDtmlhWEStFSWPDugb9QZqTqIfXYApMToEKf53f
 4tmEc4x5Lz84wV9sx6TGRXLL6FB7GeHzHBYxhcWaFaiTZfJz1li+1A+LqbhqBvDH4PyV
 dprpzG6riICMaz3CjfRQ+1Swgp/fqQm8Ndute9O6+77EkhIIy+mUj7uhCkQMFCMmw6gA
 sRpMYjFUk/5ybC85VRi1TiPD7DttTqy0ogRsRpbHGDUDNJma1jc+cAsaQ1ggL10/8k8a
 G6Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604427; x=1778209227;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8TVgbbpxkHLrusuF01rmOkHkuKzT9qf01Hq+f6K8dVk=;
 b=yUR2rODBBy+w8su7WV1Zzao/4elc1UKPoc4GC+NuDoarzBX0fKLaiP6oaBdogOYvuz
 NwxNeJQOetsdGAa10hzaRRoOD4r6n+BW+cQCjhLa3QnhQ4bFSS61TkcEYaJkdPu5TGz+
 /+iB6uV0EJEGzTHTtw0v6/W4qQ1PT1zVkusH4e4Is5dT8IJCB7FTj2e6RpqaPtQ/ACv0
 s0F7+ily2wZ8JdkiFas5HC4ocghxABARWAhfBz0bsnD6sg+Ug3y2tmhua3hv+LP5wCmh
 jnuNR9Yu8oOnExxwUrmVUqfB177sEIvEgT97R/w+kDbyhWlvZf0Qe4RPqar1dHir3zxn
 C9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604427; x=1778209227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TVgbbpxkHLrusuF01rmOkHkuKzT9qf01Hq+f6K8dVk=;
 b=StLhIsCUfXNSpX8j+6U7AxGqK3N1WPUzgKD4B9Nr6PZfBDNheeWqdXK1uHT0vdpuba
 Y5OAEjayPd0gX0NGnWRS50Yasu4doIhtvmLMooN4gtj+JVDaywlEUZ3lqGMBCjhf6f5H
 xPJuk07/GyPBIfVCBXDffOLYnTUNR1K/QyJkytsw9QF9kga37flOrlSg3GRbWK2XROhk
 CDqIrLc2KbTLULCnf8FPsVbiuTAvPTRTc+LHmWG/uNEpcVupv8nX9BO7yAdFSS+hai+2
 85jBdNM3DzqvSLywsKeAEbfOE6zPIC75exqbKoVzLunZLCvlvOtShwVaknR6EB4sXf9j
 u8Hw==
X-Gm-Message-State: AOJu0YywoAoGQwDeh6/yJQxYTPjZuegJ9qgQWVUYmKeq1/NORsTyr77g
 kqshsswRI0oFR9upWeLUdbqCSpp+S8UhWd0l2++nJsPi9F7VWCyHMOfZGkTlXZuoDkzxkX8I0t0
 05IwK+vAeVE8cqOlD9Hbfyh8Y7O4+vhyiYzLP9fD/FkfljfbCcuNtDnQ=
X-Gm-Gg: AeBDieuz4BXEa1v65J2yMzYGSB4RdoSLhP3h6w6M8foQn9D+38oj67uhk16K8iieNNc
 3z6tw8uwahs56EwM5VMyGO7dvNnZAo980z4JjZDwLg3oyxRV5W6a6bn68Aqw7SEHbc5XfhB/Edo
 zdeZHf8tjQ08KJpCxrIGcnxbE2YZqNiL92MYuvhaJjmaSfbmzVyrx9VJpu5QymBfDbfoxqiRRZy
 kfZFBDBykV5cAz3dkeeoVDVrQVhrOHPpjAudAYUSgN8ovxED8keu+Pb2CU5ZgVWSza1qOs2KIIO
 gmzR9buudiV8YcjhVg==
X-Received: by 2002:a05:690e:d47:b0:650:1ddf:32c0 with SMTP id
 956f58d0204a3-65c18f2fafbmr4562455d50.48.1777604426469; Thu, 30 Apr 2026
 20:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
 <20260429-syscall-nr-v2-5-67a8d09dc13e@bsdimp.com>
 <afMQRlu2_ONaBxCX@redhat.com>
 <CANCZdfqAFREcN_xvYYcVjWCih5m0Oe1GTeFxt4h3DLvJU78bcg@mail.gmail.com>
In-Reply-To: <CANCZdfqAFREcN_xvYYcVjWCih5m0Oe1GTeFxt4h3DLvJU78bcg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 21:00:13 -0600
X-Gm-Features: AVHnY4JkmC7IHH4T9_kIVgjFz1MJ9m-o7qFxVe2AVtLr0sHbffDGSrb_hIMGFnQ
Message-ID: <CANCZdfo=wEBECqRNs9YkTku+t3nb5+C0jKF0=uyXeS1BStSktg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bsd-user: Regnerate strace.list
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000006426370650b8c8f3"
Received-SPF: none client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=wlosh@bsdimp.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000006426370650b8c8f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:17=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote=
:

>
>
> On Thu, Apr 30, 2026 at 2:18=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com>
> wrote:
>
>> On Wed, Apr 29, 2026 at 08:38:55AM -0600, Warner Losh wrote:
>> > Note: I derived this script from one of the FreeBSD system call
>> > generation scripts, so it needs to be BSD-2-Clause license, which
>> > deviates a bit from the GPL-2.0-or-newer preference, but I think is OK
>> > since it's not folded into the qemu binaries themselves (and output of
>> > scripts is typically public domain, as is the case here).
>>
>> Yes, that's all absolutely fine - when pulling incode from outside,
>> or derived from outside, it is required to preserve the license.
>> The GPL-2.0-or-newer rule only applies to green field code written
>> for QEMU.
>>
>> It would be fine even if it applied to code that needs to be linked
>> into QEMU, since BSD-2-Clause is compatible with GPL-2 in a combined
>> work.
>>
>> >                                                           This script =
is
>> > written in lua, but every FreeBSD installation has a 'flua' binary tha=
t
>> > can run this script, and it leverages about 7k lines of library and
>> > metadata FreeBSD maintains well.
>> >
>> > Signed-off-by: Warner Losh <imp@bsdimp.com>
>> > ---
>> >  bsd-user/freebsd/scripts/strace.lua | 117 ++++++
>> >  bsd-user/freebsd/strace.list        | 708
>> ++++++++++++++++++++++--------------
>> >  2 files changed, 556 insertions(+), 269 deletions(-)
>> >
>> > diff --git a/bsd-user/freebsd/scripts/strace.lua
>> b/bsd-user/freebsd/scripts/strace.lua
>> > new file mode 100755
>> > index 0000000000..c89e8e3aeb
>> > --- /dev/null
>> > +++ b/bsd-user/freebsd/scripts/strace.lua
>> > @@ -0,0 +1,117 @@
>>
>> > +                             gen:write(string.format(
>> > +                                 "{ %d, \"%s\", %s, %s, NULL },\n",
>> > +                                 v.num, v.arg_alias, fmt, fcn))
>>
>> Is there a reason to use v.num, instead of the symbolic name that
>> was previously used ?  eg something like:
>>
>>     "{ TARGET_FREEBSD_NR_%s, \"%s\", %s, %s, NULL },\n",
>>     v.arg_alias, v.arg_alias, fmt, fcn))
>>
>
> Yes. Since we're now generating the TARGET_FREEBSD_NR_ symbols from
> sys/syscalls.h,
> there are going to be some that are undefined. FreeBSD current introduces
> new system calls
> from time to time that older, but still supported, branches do not have. =
I
> watned one file that
> would work on all supported versions. Since adding an #ifdef before each
> line exploded things,
> and since you can't macroize #ifdef, and since the FreeBSD system call
> numbers are completely
> stable and never change and since humans rarely read this file, I used th=
e
> number so that it
> would work everywhere.  I thought about adding a comment on each line, bu=
t
> the syscall name
> is the next field over so it wouldn't add much, if any, value.
>
>
>>
>> > diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.li=
st
>> > index d7f61f480e..2c4176475a 100644
>> > --- a/bsd-user/freebsd/strace.list
>> > +++ b/bsd-user/freebsd/strace.list
>> > @@ -1,273 +1,443 @@
>> >  /*
>>
>> If comparing the first few:
>>
>> > -{ TARGET_FREEBSD_NR___acl_aclcheck_fd, "__acl_aclcheck_fd", "%s(%d,
>> %d, %#x)", NULL, NULL },
>> > -{ TARGET_FREEBSD_NR___acl_aclcheck_file, "__acl_aclcheck_file",
>> "%s(\"%s\", %d, %#x)", NULL, NULL },
>> > -{ TARGET_FREEBSD_NR___acl_aclcheck_link, "__acl_aclcheck_link",
>> "%s(\"%s\", %d, %#x)", NULL, NULL },
>>
>> vs
>>
>> > +{ 354, "__acl_aclcheck_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 353, "__acl_aclcheck_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 428, "__acl_aclcheck_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>>
>> The args pattern has changed significantly. Everything is now
>> %#x, where as before it was formatting strings and integers.
>>
>> Looking further at just the new definitions, essentially
>> everything is now %#x.  Is that really intentional ? If
>> so just put a note in the commit message about why nearly
>> all the args are changing format.
>>
>
> Hmmm, That's surprising to me. I'll double check what's going on to make
> sure my logic is correct since that's not what was intended, nor what
> earlier versions of the script produced.
>

OK. Something really weird is going on, so I'm going to drop the last hunk
of the
patch, and resend the patch one more time because I had too many files adde=
d
to bsd-user/freebsd/meson.build.

Warner


> Warner
>
>
>> > +{ 352, "__acl_delete_fd_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 351, "__acl_delete_file_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 427, "__acl_delete_link_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 349, "__acl_get_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 347, "__acl_get_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 425, "__acl_get_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 350, "__acl_set_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 348, "__acl_set_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 426, "__acl_set_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 515, "__cap_rights_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 326, "__getcwd_args", "%s(%s, %#x)", NULL, NULL },
>> > +{ 415, "__mac_execve_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 386, "__mac_get_fd_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 387, "__mac_get_file_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 410, "__mac_get_link_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 409, "__mac_get_pid_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 384, "__mac_get_proc_args", "%s(%#x)", NULL, NULL },
>> > +{ 388, "__mac_set_fd_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 389, "__mac_set_file_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 411, "__mac_set_link_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 385, "__mac_set_proc_args", "%s(%#x)", NULL, NULL },
>> > +{ 574, "__realpathat_args", "%s(%#x, %#x, %s, %#x, %#x)", NULL, NULL =
},
>> > +{ 510, "__semctl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 374, "__setugid_args", "%s(%#x)", NULL, NULL },
>> > +{ 577, "__specialfd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 202, "__sysctl_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NUL=
L
>> },
>> > +{ 570, "__sysctlbyname_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
>> NULL, NULL },
>> > +{ 1, "_exit_args", "%s(%#x)", NULL, NULL },
>> > +{ 454, "_umtx_op_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 463, "abort2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 541, "accept4_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 30, "accept_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 33, "access_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 51, "acct_args", "%s(%#x)", NULL, NULL },
>> > +{ 140, "adjtime_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 377, "afs3_syscall_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)",
>> NULL, NULL },
>> > +{ 316, "aio_cancel_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 317, "aio_error_args", "%s(%#x)", NULL, NULL },
>> > +{ 465, "aio_fsync_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 543, "aio_mlock_args", "%s(%#x)", NULL, NULL },
>> > +{ 255, "aio_read_args", "%s(%#x)", NULL, NULL },
>> > +{ 579, "aio_readv_args", "%s(%#x)", NULL, NULL },
>> > +{ 314, "aio_return_args", "%s(%#x)", NULL, NULL },
>> > +{ 315, "aio_suspend_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 359, "aio_waitcomplete_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 256, "aio_write_args", "%s(%#x)", NULL, NULL },
>> > +{ 578, "aio_writev_args", "%s(%#x)", NULL, NULL },
>> > +{ 445, "audit_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 453, "auditctl_args", "%s(%#x)", NULL, NULL },
>> > +{ 446, "auditon_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 104, "bind_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 538, "bindat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 17, "break_args", "%s(%s)", NULL, NULL },
>> > +{ 516, "cap_enter_args", NULL, NULL, NULL },
>> > +{ 537, "cap_fcntls_get_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 536, "cap_fcntls_limit_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 517, "cap_getmode_args", "%s(%#x)", NULL, NULL },
>> > +{ 535, "cap_ioctls_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 534, "cap_ioctls_limit_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 533, "cap_rights_limit_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 12, "chdir_args", "%s(%#x)", NULL, NULL },
>> > +{ 34, "chflags_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 540, "chflagsat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 15, "chmod_args", "%s(%#x, %o)", NULL, NULL },
>> > +{ 16, "chown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 61, "chroot_args", "%s(%#x)", NULL, NULL },
>> > +{ 247, "clock_getcpuclockid2_args", "%s(%#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 234, "clock_getres_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 232, "clock_gettime_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 244, "clock_nanosleep_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 233, "clock_settime_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 6, "close_args", "%s(%#x)", NULL, NULL },
>> > +{ 575, "close_range_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 98, "connect_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 539, "connectat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 569, "copy_file_range_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
>> NULL, NULL },
>> > +{ 484, "cpuset_args", "%s(%#x)", NULL, NULL },
>> > +{ 487, "cpuset_getaffinity_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL=
,
>> NULL },
>> > +{ 561, "cpuset_getdomain_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
>> NULL, NULL },
>> > +{ 486, "cpuset_getid_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 488, "cpuset_setaffinity_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL=
,
>> NULL },
>> > +{ 562, "cpuset_setdomain_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
>> NULL, NULL },
>> > +{ 485, "cpuset_setid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 90, "dup2_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 41, "dup_args", "%s(%#x)", NULL, NULL },
>> > +{ 376, "eaccess_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 59, "execve_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 373, "extattr_delete_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 358, "extattr_delete_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 414, "extattr_delete_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 372, "extattr_get_fd_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 357, "extattr_get_file_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 413, "extattr_get_link_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 437, "extattr_list_fd_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 438, "extattr_list_file_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL
>> },
>> > +{ 439, "extattr_list_link_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL
>> },
>> > +{ 371, "extattr_set_fd_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 356, "extattr_set_file_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 412, "extattr_set_link_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 355, "extattrctl_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 592, "exterrctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 489, "faccessat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 13, "fchdir_args", "%s(%#x)", NULL, NULL },
>> > +{ 35, "fchflags_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 124, "fchmod_args", "%s(%#x, %o)", NULL, NULL },
>> > +{ 490, "fchmodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
>> > +{ 123, "fchown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 491, "fchownat_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 590, "fchroot_args", "%s(%#x)", NULL, NULL },
>> > +{ 92, "fcntl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 550, "fdatasync_args", "%s(%#x)", NULL, NULL },
>> > +{ 492, "fexecve_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 241, "ffclock_getcounter_args", "%s(%#x)", NULL, NULL },
>> > +{ 243, "ffclock_getestimate_args", "%s(%#x)", NULL, NULL },
>> > +{ 242, "ffclock_setestimate_args", "%s(%#x)", NULL, NULL },
>> > +{ 565, "fhlink_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 566, "fhlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 298, "fhopen_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 567, "fhreadlink_args", "%s(%#x, %s, %#x)", NULL, NULL },
>> > +{ 553, "fhstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 558, "fhstatfs_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 131, "flock_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 2, "fork_args", NULL, NULL, NULL },
>> > +{ 192, "fpathconf_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 434, "freebsd10__umtx_lock_args", "%s(%#x)", NULL, NULL },
>> > +{ 435, "freebsd10__umtx_unlock_args", "%s(%#x)", NULL, NULL },
>> > +{ 42, "freebsd10_pipe_args", NULL, NULL, NULL },
>> > +{ 299, "freebsd11_fhstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 398, "freebsd11_fhstatfs_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 189, "freebsd11_fstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 493, "freebsd11_fstatat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL
>> },
>> > +{ 397, "freebsd11_fstatfs_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 272, "freebsd11_getdents_args", "%s(%#x, %s, %#x)", NULL, NULL },
>> > +{ 196, "freebsd11_getdirentries_args", "%s(%#x, %s, %#x, %#x)", NULL,
>> NULL },
>> > +{ 395, "freebsd11_getfsstat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 363, "freebsd11_kevent_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)",
>> NULL, NULL },
>> > +{ 190, "freebsd11_lstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 14, "freebsd11_mknod_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 498, "freebsd11_mknodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL =
},
>> > +{ 279, "freebsd11_nfstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 280, "freebsd11_nlstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 278, "freebsd11_nstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 188, "freebsd11_stat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 396, "freebsd11_statfs_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 72, "freebsd11_vadvise_args", "%s(%#x)", NULL, NULL },
>> > +{ 509, "freebsd12_closefrom_args", "%s(%#x)", NULL, NULL },
>> > +{ 482, "freebsd12_shm_open_args", "%s(%#x, %#x, %o)", NULL, NULL },
>> > +{ 424, "freebsd13_swapoff_args", "%s(%#x)", NULL, NULL },
>> > +{ 79, "freebsd14_getgroups_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 80, "freebsd14_setgroups_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 580, "fspacectl_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 551, "fstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 552, "fstatat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 556, "fstatfs_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 95, "fsync_args", "%s(%#x)", NULL, NULL },
>> > +{ 480, "ftruncate_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 568, "funlinkat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 546, "futimens_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 206, "futimes_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 494, "futimesat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 451, "getaudit_addr_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 449, "getaudit_args", "%s(%#x)", NULL, NULL },
>> > +{ 447, "getauid_args", "%s(%#x)", NULL, NULL },
>> > +{ 421, "getcontext_args", "%s(%#x)", NULL, NULL },
>> > +{ 554, "getdirentries_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
>> > +{ 89, "getdtablesize_args", NULL, NULL, NULL },
>> > +{ 43, "getegid_args", NULL, NULL, NULL },
>> > +{ 25, "geteuid_args", NULL, NULL, NULL },
>> > +{ 161, "getfh_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 564, "getfhat_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
>> > +{ 557, "getfsstat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 47, "getgid_args", NULL, NULL, NULL },
>> > +{ 595, "getgroups_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 86, "getitimer_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 49, "getlogin_args", "%s(%s, %#x)", NULL, NULL },
>> > +{ 523, "getloginclass_args", "%s(%s, %#x)", NULL, NULL },
>> > +{ 31, "getpeername_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 207, "getpgid_args", "%s(%#x)", NULL, NULL },
>> > +{ 81, "getpgrp_args", NULL, NULL, NULL },
>> > +{ 20, "getpid_args", NULL, NULL, NULL },
>> > +{ 39, "getppid_args", NULL, NULL, NULL },
>> > +{ 100, "getpriority_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 563, "getrandom_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 361, "getresgid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 360, "getresuid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 194, "getrlimit_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 589, "getrlimitusage_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 117, "getrusage_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 310, "getsid_args", "%s(%#x)", NULL, NULL },
>> > +{ 32, "getsockname_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 118, "getsockopt_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 116, "gettimeofday_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 24, "getuid_args", NULL, NULL, NULL },
>> > +{ 593, "inotify_add_watch_at_args", "%s(%#x, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 594, "inotify_rm_watch_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 54, "ioctl_args", "%s(%#x, %#x, %s)", NULL, NULL },
>> > +{ 253, "issetugid_args", NULL, NULL, NULL },
>> > +{ 338, "jail_args", "%s(%#x)", NULL, NULL },
>> > +{ 436, "jail_attach_args", "%s(%#x)", NULL, NULL },
>> > +{ 597, "jail_attach_jd_args", "%s(%#x)", NULL, NULL },
>> > +{ 506, "jail_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 508, "jail_remove_args", "%s(%#x)", NULL, NULL },
>> > +{ 598, "jail_remove_jd_args", "%s(%#x)", NULL, NULL },
>> > +{ 507, "jail_set_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 588, "kcmp_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 390, "kenv_args", "%s(%#x, %#x, %s, %#x)", NULL, NULL },
>> > +{ 560, "kevent_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL =
},
>> > +{ 599, "kexec_load_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 37, "kill_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 306, "kldfind_args", "%s(%#x)", NULL, NULL },
>> > +{ 309, "kldfirstmod_args", "%s(%#x)", NULL, NULL },
>> > +{ 304, "kldload_args", "%s(%#x)", NULL, NULL },
>> > +{ 307, "kldnext_args", "%s(%#x)", NULL, NULL },
>> > +{ 308, "kldstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 337, "kldsym_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 305, "kldunload_args", "%s(%#x)", NULL, NULL },
>> > +{ 444, "kldunloadf_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 461, "kmq_notify_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 457, "kmq_open_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
>> > +{ 458, "kmq_setattr_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 459, "kmq_timedreceive_args", "%s(%#x, %s, %#x, %#x, %#x)", NULL,
>> NULL },
>> > +{ 460, "kmq_timedsend_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NUL=
L
>> },
>> > +{ 462, "kmq_unlink_args", "%s(%#x)", NULL, NULL },
>> > +{ 362, "kqueue_args", NULL, NULL, NULL },
>> > +{ 583, "kqueuex_args", "%s(%#x)", NULL, NULL },
>> > +{ 400, "ksem_close_args", "%s(%#x)", NULL, NULL },
>> > +{ 408, "ksem_destroy_args", "%s(%#x)", NULL, NULL },
>> > +{ 407, "ksem_getvalue_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 404, "ksem_init_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 405, "ksem_open_args", "%s(%#x, %#x, %#x, %o, %#x)", NULL, NULL },
>> > +{ 401, "ksem_post_args", "%s(%#x)", NULL, NULL },
>> > +{ 441, "ksem_timedwait_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 403, "ksem_trywait_args", "%s(%#x)", NULL, NULL },
>> > +{ 406, "ksem_unlink_args", "%s(%#x)", NULL, NULL },
>> > +{ 402, "ksem_wait_args", "%s(%#x)", NULL, NULL },
>> > +{ 235, "ktimer_create_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 236, "ktimer_delete_args", "%s(%#x)", NULL, NULL },
>> > +{ 239, "ktimer_getoverrun_args", "%s(%#x)", NULL, NULL },
>> > +{ 238, "ktimer_gettime_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 237, "ktimer_settime_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 45, "ktrace_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 391, "lchflags_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 274, "lchmod_args", "%s(%#x, %o)", NULL, NULL },
>> > +{ 254, "lchown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 160, "lgetfh_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 9, "link_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 495, "linkat_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 257, "lio_listio_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 106, "listen_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 513, "lpathconf_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 478, "lseek_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 276, "lutimes_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 394, "mac_syscall_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 75, "madvise_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 584, "membarrier_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 78, "mincore_args", "%s(%#x, %#x, %s)", NULL, NULL },
>> > +{ 250, "minherit_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 136, "mkdir_args", "%s(%#x, %o)", NULL, NULL },
>> > +{ 496, "mkdirat_args", "%s(%#x, %#x, %o)", NULL, NULL },
>> > +{ 132, "mkfifo_args", "%s(%#x, %o)", NULL, NULL },
>> > +{ 497, "mkfifoat_args", "%s(%#x, %#x, %o)", NULL, NULL },
>> > +{ 559, "mknodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
>> > +{ 203, "mlock_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 324, "mlockall_args", "%s(%#x)", NULL, NULL },
>> > +{ 477, "mmap_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 303, "modfind_args", "%s(%#x)", NULL, NULL },
>> > +{ 302, "modfnext_args", "%s(%#x)", NULL, NULL },
>> > +{ 300, "modnext_args", "%s(%#x)", NULL, NULL },
>> > +{ 301, "modstat_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 21, "mount_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 74, "mprotect_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 511, "msgctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 225, "msgget_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 227, "msgrcv_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 226, "msgsnd_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 170, "msgsys_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL =
},
>> > +{ 65, "msync_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 204, "munlock_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 325, "munlockall_args", NULL, NULL, NULL },
>> > +{ 73, "munmap_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 240, "nanosleep_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 155, "nfssvc_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 154, "nlm_syscall_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 378, "nmount_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 339, "nnpfs_syscall_args", "%s(%#x, %s, %#x, %#x, %#x)", NULL, NULL
>> },
>> > +{ 176, "ntp_adjtime_args", "%s(%#x)", NULL, NULL },
>> > +{ 248, "ntp_gettime_args", "%s(%#x)", NULL, NULL },
>> > +{ 5, "open_args", "%s(%#x, %#x, %o)", NULL, NULL },
>> > +{ 499, "openat_args", "%s(%#x, %#x, %#x, %o)", NULL, NULL },
>> > +{ 191, "pathconf_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 518, "pdfork_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 520, "pdgetpid_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 519, "pdkill_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 600, "pdrfork_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 601, "pdwait_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 542, "pipe2_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 209, "poll_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 531, "posix_fadvise_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 530, "posix_fallocate_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 504, "posix_openpt_args", "%s(%#x)", NULL, NULL },
>> > +{ 545, "ppoll_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 475, "pread_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 289, "preadv_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 544, "procctl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 44, "profil_args", "%s(%s, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 522, "pselect_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL
>> },
>> > +{ 26, "ptrace_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 476, "pwrite_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 290, "pwritev_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 148, "quotactl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 528, "rctl_add_rule_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 527, "rctl_get_limits_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 525, "rctl_get_racct_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 526, "rctl_get_rules_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 529, "rctl_remove_rule_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL =
},
>> > +{ 3, "read_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 58, "readlink_args", "%s(%#x, %s, %#x)", NULL, NULL },
>> > +{ 500, "readlinkat_args", "%s(%#x, %#x, %s, %#x)", NULL, NULL },
>> > +{ 120, "readv_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 55, "reboot_args", "%s(%#x)", NULL, NULL },
>> > +{ 29, "recvfrom_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL
>> },
>> > +{ 27, "recvmsg_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 128, "rename_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 602, "renameat2_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 501, "renameat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 56, "revoke_args", "%s(%#x)", NULL, NULL },
>> > +{ 251, "rfork_args", "%s(%#x)", NULL, NULL },
>> > +{ 137, "rmdir_args", "%s(%#x)", NULL, NULL },
>> > +{ 576, "rpctls_syscall_args", "%s(%#x)", NULL, NULL },
>> > +{ 166, "rtprio_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 466, "rtprio_thread_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 332, "sched_get_priority_max_args", "%s(%#x)", NULL, NULL },
>> > +{ 333, "sched_get_priority_min_args", "%s(%#x)", NULL, NULL },
>> > +{ 581, "sched_getcpu_args", NULL, NULL, NULL },
>> > +{ 328, "sched_getparam_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 330, "sched_getscheduler_args", "%s(%#x)", NULL, NULL },
>> > +{ 334, "sched_rr_get_interval_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 327, "sched_setparam_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 329, "sched_setscheduler_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 331, "sched_yield_args", NULL, NULL, NULL },
>> > +{ 474, "sctp_generic_recvmsg_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x,
>> %#x)", NULL, NULL },
>> > +{ 472, "sctp_generic_sendmsg_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x,
>> %#x)", NULL, NULL },
>> > +{ 473, "sctp_generic_sendmsg_iov_args", "%s(%#x, %#x, %#x, %#x, %#x,
>> %#x, %#x)", NULL, NULL },
>> > +{ 471, "sctp_peeloff_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 93, "select_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 221, "semget_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 222, "semop_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 169, "semsys_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 393, "sendfile_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL=
,
>> NULL },
>> > +{ 28, "sendmsg_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 133, "sendto_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL =
},
>> > +{ 452, "setaudit_addr_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 450, "setaudit_args", "%s(%#x)", NULL, NULL },
>> > +{ 448, "setauid_args", "%s(%#x)", NULL, NULL },
>> > +{ 422, "setcontext_args", "%s(%#x)", NULL, NULL },
>> > +{ 591, "setcred_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 182, "setegid_args", "%s(%#x)", NULL, NULL },
>> > +{ 183, "seteuid_args", "%s(%#x)", NULL, NULL },
>> > +{ 175, "setfib_args", "%s(%#x)", NULL, NULL },
>> > +{ 181, "setgid_args", "%s(%#x)", NULL, NULL },
>> > +{ 596, "setgroups_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 83, "setitimer_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 50, "setlogin_args", "%s(%#x)", NULL, NULL },
>> > +{ 524, "setloginclass_args", "%s(%#x)", NULL, NULL },
>> > +{ 82, "setpgid_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 96, "setpriority_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 127, "setregid_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 312, "setresgid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 311, "setresuid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 126, "setreuid_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 195, "setrlimit_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 147, "setsid_args", NULL, NULL, NULL },
>> > +{ 105, "setsockopt_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 122, "settimeofday_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 23, "setuid_args", "%s(%#x)", NULL, NULL },
>> > +{ 571, "shm_open2_args", "%s(%#x, %#x, %o, %#x, %#x)", NULL, NULL },
>> > +{ 572, "shm_rename_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 483, "shm_unlink_args", "%s(%#x)", NULL, NULL },
>> > +{ 228, "shmat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 512, "shmctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 230, "shmdt_args", "%s(%#x)", NULL, NULL },
>> > +{ 231, "shmget_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 171, "shmsys_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 134, "shutdown_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 416, "sigaction_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 53, "sigaltstack_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 573, "sigfastblock_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 343, "sigpending_args", "%s(%#x)", NULL, NULL },
>> > +{ 340, "sigprocmask_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 456, "sigqueue_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 417, "sigreturn_args", "%s(%#x)", NULL, NULL },
>> > +{ 341, "sigsuspend_args", "%s(%#x)", NULL, NULL },
>> > +{ 345, "sigtimedwait_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 429, "sigwait_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 346, "sigwaitinfo_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 97, "socket_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 135, "socketpair_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 555, "statfs_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 423, "swapcontext_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 582, "swapoff_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 85, "swapon_args", "%s(%#x)", NULL, NULL },
>> > +{ 57, "symlink_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 502, "symlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 36, "sync_args", NULL, NULL, NULL },
>> > +{ 165, "sysarch_args", "%s(%#x, %s)", NULL, NULL },
>> > +{ 430, "thr_create_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 431, "thr_exit_args", "%s(%#x)", NULL, NULL },
>> > +{ 481, "thr_kill2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 433, "thr_kill_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 455, "thr_new_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 432, "thr_self_args", "%s(%#x)", NULL, NULL },
>> > +{ 464, "thr_set_name_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 442, "thr_suspend_args", "%s(%#x)", NULL, NULL },
>> > +{ 443, "thr_wake_args", "%s(%#x)", NULL, NULL },
>> > +{ 585, "timerfd_create_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 586, "timerfd_gettime_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 587, "timerfd_settime_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 479, "truncate_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 60, "umask_args", "%s(%o)", NULL, NULL },
>> > +{ 205, "undelete_args", "%s(%#x)", NULL, NULL },
>> > +{ 10, "unlink_args", "%s(%#x)", NULL, NULL },
>> > +{ 503, "unlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 22, "unmount_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 547, "utimensat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 138, "utimes_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 335, "utrace_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 392, "uuidgen_args", "%s(%#x, %#x)", NULL, NULL },
>> > +{ 66, "vfork_args", NULL, NULL, NULL },
>> > +{ 7, "wait4_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
>> > +{ 532, "wait6_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL }=
,
>> > +{ 4, "write_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 121, "writev_args", "%s(%#x, %#x, %#x)", NULL, NULL },
>> > +{ 321, "yield_args", NULL, NULL, NULL },
>> >
>> > --
>> > 2.52.0
>> >
>>
>>

--0000000000006426370650b8c8f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30,=
 2026 at 10:17=E2=80=AFAM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
>imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30, 2026=
 at 2:18=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@=
redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Apr 29, 2026 at 08=
:38:55AM -0600, Warner Losh wrote:<br>
&gt; Note: I derived this script from one of the FreeBSD system call<br>
&gt; generation scripts, so it needs to be BSD-2-Clause license, which<br>
&gt; deviates a bit from the GPL-2.0-or-newer preference, but I think is OK=
<br>
&gt; since it&#39;s not folded into the qemu binaries themselves (and outpu=
t of<br>
&gt; scripts is typically public domain, as is the case here).<br>
<br>
Yes, that&#39;s all absolutely fine - when pulling incode from outside,<br>
or derived from outside, it is required to preserve the license.<br>
The GPL-2.0-or-newer rule only applies to green field code written<br>
for QEMU.<br>
<br>
It would be fine even if it applied to code that needs to be linked<br>
into QEMU, since BSD-2-Clause is compatible with GPL-2 in a combined<br>
work.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This scri=
pt is<br>
&gt; written in lua, but every FreeBSD installation has a &#39;flua&#39; bi=
nary that<br>
&gt; can run this script, and it leverages about 7k lines of library and<br=
>
&gt; metadata FreeBSD maintains well.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/freebsd/scripts/strace.lua | 117 ++++++<br>
&gt;=C2=A0 bsd-user/freebsd/strace.list=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 708 ++=
++++++++++++++++++++--------------<br>
&gt;=C2=A0 2 files changed, 556 insertions(+), 269 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/freebsd/scripts/strace.lua b/bsd-user/freebsd/sc=
ripts/strace.lua<br>
&gt; new file mode 100755<br>
&gt; index 0000000000..c89e8e3aeb<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/freebsd/scripts/strace.lua<br>
&gt; @@ -0,0 +1,117 @@<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen:write(string.format(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{ %d, \&quot;%s\&quo=
t;, %s, %s, NULL },\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v.num, v.arg_alias, fmt, f=
cn))<br>
<br>
Is there a reason to use v.num, instead of the symbolic name that<br>
was previously used ?=C2=A0 eg something like:<br>
<br>
=C2=A0 =C2=A0 &quot;{ TARGET_FREEBSD_NR_%s, \&quot;%s\&quot;, %s, %s, NULL =
},\n&quot;,<br>
=C2=A0 =C2=A0 v.arg_alias, v.arg_alias, fmt, fcn))<br></blockquote><div><br=
></div><div>Yes. Since we&#39;re now generating the TARGET_FREEBSD_NR_ symb=
ols from sys/syscalls.h,</div><div>there are going to be some that are unde=
fined. FreeBSD current introduces new system calls</div><div>from time to t=
ime that older, but still supported, branches do not have. I watned one fil=
e that</div><div>would work on all supported versions. Since adding an #ifd=
ef before each line exploded things,</div><div>and since you can&#39;t macr=
oize #ifdef, and since the FreeBSD system call numbers are completely</div>=
<div>stable and never change and since humans rarely read this file, I used=
 the number so that it</div><div>would work everywhere.=C2=A0 I thought abo=
ut adding a comment on each line, but the syscall name</div><div>is the nex=
t field over so it wouldn&#39;t add much, if any, value.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.li=
st<br>
&gt; index d7f61f480e..2c4176475a 100644<br>
&gt; --- a/bsd-user/freebsd/strace.list<br>
&gt; +++ b/bsd-user/freebsd/strace.list<br>
&gt; @@ -1,273 +1,443 @@<br>
&gt;=C2=A0 /*<br>
<br>
If comparing the first few:<br>
<br>
&gt; -{ TARGET_FREEBSD_NR___acl_aclcheck_fd, &quot;__acl_aclcheck_fd&quot;,=
 &quot;%s(%d, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_aclcheck_file, &quot;__acl_aclcheck_file&qu=
ot;, &quot;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
&gt; -{ TARGET_FREEBSD_NR___acl_aclcheck_link, &quot;__acl_aclcheck_link&qu=
ot;, &quot;%s(\&quot;%s\&quot;, %d, %#x)&quot;, NULL, NULL },<br>
<br>
vs<br>
<br>
&gt; +{ 354, &quot;__acl_aclcheck_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 353, &quot;__acl_aclcheck_file_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 428, &quot;__acl_aclcheck_link_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
<br>
The args pattern has changed significantly. Everything is now<br>
%#x, where as before it was formatting strings and integers.<br>
<br>
Looking further at just the new definitions, essentially<br>
everything is now %#x.=C2=A0 Is that really intentional ? If<br>
so just put a note in the commit message about why nearly<br>
all the args are changing format.<br></blockquote><div><br></div><div>Hmmm,=
 That&#39;s surprising to me. I&#39;ll double check what&#39;s going on to =
make</div><div>sure my logic is correct since that&#39;s not what was inten=
ded, nor what</div><div>earlier versions of the script produced.</div></div=
></div></blockquote><div><br></div><div>OK. Something really weird is going=
 on, so I&#39;m going to drop the last hunk of the</div><div>patch, and res=
end the patch one more time because I had too many files added</div><div>to=
 bsd-user/freebsd/meson.build.</div><div><br></div><div>Warner</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_quote"><div>Warner</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; +{ 352, &quot;__acl_delete_fd_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 351, &quot;__acl_delete_file_args&quot;, &quot;%s(%#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 427, &quot;__acl_delete_link_args&quot;, &quot;%s(%#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 349, &quot;__acl_get_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 347, &quot;__acl_get_file_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 425, &quot;__acl_get_link_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 350, &quot;__acl_set_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 348, &quot;__acl_set_file_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 426, &quot;__acl_set_link_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 515, &quot;__cap_rights_get_args&quot;, &quot;%s(%#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 326, &quot;__getcwd_args&quot;, &quot;%s(%s, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 415, &quot;__mac_execve_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 386, &quot;__mac_get_fd_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 387, &quot;__mac_get_file_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 410, &quot;__mac_get_link_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 409, &quot;__mac_get_pid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 384, &quot;__mac_get_proc_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 388, &quot;__mac_set_fd_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 389, &quot;__mac_set_file_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 411, &quot;__mac_set_link_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 385, &quot;__mac_set_proc_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 574, &quot;__realpathat_args&quot;, &quot;%s(%#x, %#x, %s, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 510, &quot;__semctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 374, &quot;__setugid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 577, &quot;__specialfd_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 202, &quot;__sysctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %=
#x)&quot;, NULL, NULL },<br>
&gt; +{ 570, &quot;__sysctlbyname_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, =
%#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 1, &quot;_exit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 454, &quot;_umtx_op_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 463, &quot;abort2_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 541, &quot;accept4_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 30, &quot;accept_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 33, &quot;access_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 51, &quot;acct_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 140, &quot;adjtime_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 377, &quot;afs3_syscall_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#=
x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 316, &quot;aio_cancel_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 317, &quot;aio_error_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 465, &quot;aio_fsync_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 543, &quot;aio_mlock_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 255, &quot;aio_read_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 579, &quot;aio_readv_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 314, &quot;aio_return_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 315, &quot;aio_suspend_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 359, &quot;aio_waitcomplete_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 256, &quot;aio_write_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 578, &quot;aio_writev_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 445, &quot;audit_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 453, &quot;auditctl_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 446, &quot;auditon_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 104, &quot;bind_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 538, &quot;bindat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 17, &quot;break_args&quot;, &quot;%s(%s)&quot;, NULL, NULL },<br>
&gt; +{ 516, &quot;cap_enter_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 537, &quot;cap_fcntls_get_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 536, &quot;cap_fcntls_limit_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 517, &quot;cap_getmode_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 535, &quot;cap_ioctls_get_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 534, &quot;cap_ioctls_limit_args&quot;, &quot;%s(%#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 533, &quot;cap_rights_limit_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 12, &quot;chdir_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 34, &quot;chflags_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 540, &quot;chflagsat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 15, &quot;chmod_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL },<=
br>
&gt; +{ 16, &quot;chown_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 61, &quot;chroot_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 247, &quot;clock_getcpuclockid2_args&quot;, &quot;%s(%#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 234, &quot;clock_getres_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 232, &quot;clock_gettime_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 244, &quot;clock_nanosleep_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 233, &quot;clock_settime_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 6, &quot;close_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 575, &quot;close_range_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 98, &quot;connect_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 539, &quot;connectat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 569, &quot;copy_file_range_args&quot;, &quot;%s(%#x, %#x, %#x, %#x,=
 %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 484, &quot;cpuset_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 487, &quot;cpuset_getaffinity_args&quot;, &quot;%s(%#x, %#x, %#x, %=
#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 561, &quot;cpuset_getdomain_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 486, &quot;cpuset_getid_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 488, &quot;cpuset_setaffinity_args&quot;, &quot;%s(%#x, %#x, %#x, %=
#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 562, &quot;cpuset_setdomain_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 485, &quot;cpuset_setid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 90, &quot;dup2_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 41, &quot;dup_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 376, &quot;eaccess_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 59, &quot;execve_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 373, &quot;extattr_delete_fd_args&quot;, &quot;%s(%#x, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 358, &quot;extattr_delete_file_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 414, &quot;extattr_delete_link_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 372, &quot;extattr_get_fd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, =
%#x)&quot;, NULL, NULL },<br>
&gt; +{ 357, &quot;extattr_get_file_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 413, &quot;extattr_get_link_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 437, &quot;extattr_list_fd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 438, &quot;extattr_list_file_args&quot;, &quot;%s(%#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 439, &quot;extattr_list_link_args&quot;, &quot;%s(%#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 371, &quot;extattr_set_fd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, =
%#x)&quot;, NULL, NULL },<br>
&gt; +{ 356, &quot;extattr_set_file_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 412, &quot;extattr_set_link_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 355, &quot;extattrctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 592, &quot;exterrctl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 489, &quot;faccessat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 13, &quot;fchdir_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 35, &quot;fchflags_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 124, &quot;fchmod_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL }=
,<br>
&gt; +{ 490, &quot;fchmodat_args&quot;, &quot;%s(%#x, %#x, %o, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 123, &quot;fchown_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 491, &quot;fchownat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 590, &quot;fchroot_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 92, &quot;fcntl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 550, &quot;fdatasync_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 492, &quot;fexecve_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 241, &quot;ffclock_getcounter_args&quot;, &quot;%s(%#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 243, &quot;ffclock_getestimate_args&quot;, &quot;%s(%#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 242, &quot;ffclock_setestimate_args&quot;, &quot;%s(%#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 565, &quot;fhlink_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 566, &quot;fhlinkat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 298, &quot;fhopen_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 567, &quot;fhreadlink_args&quot;, &quot;%s(%#x, %s, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 553, &quot;fhstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 558, &quot;fhstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 131, &quot;flock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 2, &quot;fork_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 192, &quot;fpathconf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 434, &quot;freebsd10__umtx_lock_args&quot;, &quot;%s(%#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 435, &quot;freebsd10__umtx_unlock_args&quot;, &quot;%s(%#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 42, &quot;freebsd10_pipe_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 299, &quot;freebsd11_fhstat_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 398, &quot;freebsd11_fhstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 189, &quot;freebsd11_fstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 493, &quot;freebsd11_fstatat_args&quot;, &quot;%s(%#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 397, &quot;freebsd11_fstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 272, &quot;freebsd11_getdents_args&quot;, &quot;%s(%#x, %s, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 196, &quot;freebsd11_getdirentries_args&quot;, &quot;%s(%#x, %s, %#=
x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 395, &quot;freebsd11_getfsstat_args&quot;, &quot;%s(%#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 363, &quot;freebsd11_kevent_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 190, &quot;freebsd11_lstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 14, &quot;freebsd11_mknod_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 498, &quot;freebsd11_mknodat_args&quot;, &quot;%s(%#x, %#x, %o, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 279, &quot;freebsd11_nfstat_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 280, &quot;freebsd11_nlstat_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 278, &quot;freebsd11_nstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 188, &quot;freebsd11_stat_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 396, &quot;freebsd11_statfs_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 72, &quot;freebsd11_vadvise_args&quot;, &quot;%s(%#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 509, &quot;freebsd12_closefrom_args&quot;, &quot;%s(%#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 482, &quot;freebsd12_shm_open_args&quot;, &quot;%s(%#x, %#x, %o)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 424, &quot;freebsd13_swapoff_args&quot;, &quot;%s(%#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 79, &quot;freebsd14_getgroups_args&quot;, &quot;%s(%#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 80, &quot;freebsd14_setgroups_args&quot;, &quot;%s(%#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 580, &quot;fspacectl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 551, &quot;fstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 552, &quot;fstatat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 556, &quot;fstatfs_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 95, &quot;fsync_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 480, &quot;ftruncate_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 568, &quot;funlinkat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 546, &quot;futimens_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 206, &quot;futimes_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 494, &quot;futimesat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 451, &quot;getaudit_addr_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 449, &quot;getaudit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 447, &quot;getauid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 421, &quot;getcontext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 554, &quot;getdirentries_args&quot;, &quot;%s(%#x, %s, %#x, %#x)&qu=
ot;, NULL, NULL },<br>
&gt; +{ 89, &quot;getdtablesize_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 43, &quot;getegid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 25, &quot;geteuid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 161, &quot;getfh_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 564, &quot;getfhat_args&quot;, &quot;%s(%#x, %s, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 557, &quot;getfsstat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 47, &quot;getgid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 595, &quot;getgroups_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 86, &quot;getitimer_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 49, &quot;getlogin_args&quot;, &quot;%s(%s, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 523, &quot;getloginclass_args&quot;, &quot;%s(%s, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 31, &quot;getpeername_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 207, &quot;getpgid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 81, &quot;getpgrp_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 20, &quot;getpid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 39, &quot;getppid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 100, &quot;getpriority_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 563, &quot;getrandom_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 361, &quot;getresgid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 360, &quot;getresuid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 194, &quot;getrlimit_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 589, &quot;getrlimitusage_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 117, &quot;getrusage_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 310, &quot;getsid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 32, &quot;getsockname_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 118, &quot;getsockopt_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 116, &quot;gettimeofday_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 24, &quot;getuid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 593, &quot;inotify_add_watch_at_args&quot;, &quot;%s(%#x, %#x, %#x,=
 %#x)&quot;, NULL, NULL },<br>
&gt; +{ 594, &quot;inotify_rm_watch_args&quot;, &quot;%s(%#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 54, &quot;ioctl_args&quot;, &quot;%s(%#x, %#x, %s)&quot;, NULL, NUL=
L },<br>
&gt; +{ 253, &quot;issetugid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 338, &quot;jail_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 436, &quot;jail_attach_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 597, &quot;jail_attach_jd_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 506, &quot;jail_get_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 508, &quot;jail_remove_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 598, &quot;jail_remove_jd_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 507, &quot;jail_set_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 588, &quot;kcmp_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 390, &quot;kenv_args&quot;, &quot;%s(%#x, %#x, %s, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 560, &quot;kevent_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 599, &quot;kexec_load_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 37, &quot;kill_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 306, &quot;kldfind_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 309, &quot;kldfirstmod_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 304, &quot;kldload_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 307, &quot;kldnext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 308, &quot;kldstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 337, &quot;kldsym_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 305, &quot;kldunload_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 444, &quot;kldunloadf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 461, &quot;kmq_notify_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 457, &quot;kmq_open_args&quot;, &quot;%s(%#x, %#x, %o, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 458, &quot;kmq_setattr_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 459, &quot;kmq_timedreceive_args&quot;, &quot;%s(%#x, %s, %#x, %#x,=
 %#x)&quot;, NULL, NULL },<br>
&gt; +{ 460, &quot;kmq_timedsend_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %=
#x)&quot;, NULL, NULL },<br>
&gt; +{ 462, &quot;kmq_unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 362, &quot;kqueue_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 583, &quot;kqueuex_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 400, &quot;ksem_close_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 408, &quot;ksem_destroy_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 407, &quot;ksem_getvalue_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 404, &quot;ksem_init_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 405, &quot;ksem_open_args&quot;, &quot;%s(%#x, %#x, %#x, %o, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 401, &quot;ksem_post_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 441, &quot;ksem_timedwait_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 403, &quot;ksem_trywait_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 406, &quot;ksem_unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 402, &quot;ksem_wait_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 235, &quot;ktimer_create_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 236, &quot;ktimer_delete_args&quot;, &quot;%s(%#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 239, &quot;ktimer_getoverrun_args&quot;, &quot;%s(%#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 238, &quot;ktimer_gettime_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 237, &quot;ktimer_settime_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 45, &quot;ktrace_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 391, &quot;lchflags_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 274, &quot;lchmod_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL }=
,<br>
&gt; +{ 254, &quot;lchown_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 160, &quot;lgetfh_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 9, &quot;link_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 495, &quot;linkat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 257, &quot;lio_listio_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 106, &quot;listen_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 513, &quot;lpathconf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 478, &quot;lseek_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 276, &quot;lutimes_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 394, &quot;mac_syscall_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 75, &quot;madvise_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 584, &quot;membarrier_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 78, &quot;mincore_args&quot;, &quot;%s(%#x, %#x, %s)&quot;, NULL, N=
ULL },<br>
&gt; +{ 250, &quot;minherit_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 136, &quot;mkdir_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL },=
<br>
&gt; +{ 496, &quot;mkdirat_args&quot;, &quot;%s(%#x, %#x, %o)&quot;, NULL, =
NULL },<br>
&gt; +{ 132, &quot;mkfifo_args&quot;, &quot;%s(%#x, %o)&quot;, NULL, NULL }=
,<br>
&gt; +{ 497, &quot;mkfifoat_args&quot;, &quot;%s(%#x, %#x, %o)&quot;, NULL,=
 NULL },<br>
&gt; +{ 559, &quot;mknodat_args&quot;, &quot;%s(%#x, %#x, %o, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 203, &quot;mlock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 324, &quot;mlockall_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 477, &quot;mmap_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 303, &quot;modfind_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 302, &quot;modfnext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 300, &quot;modnext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 301, &quot;modstat_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 21, &quot;mount_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 74, &quot;mprotect_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 511, &quot;msgctl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 225, &quot;msgget_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 227, &quot;msgrcv_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 226, &quot;msgsnd_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 170, &quot;msgsys_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 65, &quot;msync_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 204, &quot;munlock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 325, &quot;munlockall_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 73, &quot;munmap_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 240, &quot;nanosleep_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 155, &quot;nfssvc_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 154, &quot;nlm_syscall_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 378, &quot;nmount_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 339, &quot;nnpfs_syscall_args&quot;, &quot;%s(%#x, %s, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 176, &quot;ntp_adjtime_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 248, &quot;ntp_gettime_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 5, &quot;open_args&quot;, &quot;%s(%#x, %#x, %o)&quot;, NULL, NULL =
},<br>
&gt; +{ 499, &quot;openat_args&quot;, &quot;%s(%#x, %#x, %#x, %o)&quot;, NU=
LL, NULL },<br>
&gt; +{ 191, &quot;pathconf_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 518, &quot;pdfork_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 520, &quot;pdgetpid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 519, &quot;pdkill_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 600, &quot;pdrfork_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 601, &quot;pdwait_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 542, &quot;pipe2_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 209, &quot;poll_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 531, &quot;posix_fadvise_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 530, &quot;posix_fallocate_args&quot;, &quot;%s(%#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 504, &quot;posix_openpt_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 545, &quot;ppoll_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 475, &quot;pread_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 289, &quot;preadv_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 544, &quot;procctl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 44, &quot;profil_args&quot;, &quot;%s(%s, %#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 522, &quot;pselect_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 26, &quot;ptrace_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 476, &quot;pwrite_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 290, &quot;pwritev_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 148, &quot;quotactl_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 528, &quot;rctl_add_rule_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 527, &quot;rctl_get_limits_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 525, &quot;rctl_get_racct_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 526, &quot;rctl_get_rules_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 529, &quot;rctl_remove_rule_args&quot;, &quot;%s(%#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 3, &quot;read_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 58, &quot;readlink_args&quot;, &quot;%s(%#x, %s, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 500, &quot;readlinkat_args&quot;, &quot;%s(%#x, %#x, %s, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 120, &quot;readv_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 55, &quot;reboot_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 29, &quot;recvfrom_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#=
x)&quot;, NULL, NULL },<br>
&gt; +{ 27, &quot;recvmsg_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 128, &quot;rename_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 602, &quot;renameat2_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&=
quot;, NULL, NULL },<br>
&gt; +{ 501, &quot;renameat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 56, &quot;revoke_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 251, &quot;rfork_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 137, &quot;rmdir_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 576, &quot;rpctls_syscall_args&quot;, &quot;%s(%#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 166, &quot;rtprio_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 466, &quot;rtprio_thread_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;,=
 NULL, NULL },<br>
&gt; +{ 332, &quot;sched_get_priority_max_args&quot;, &quot;%s(%#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 333, &quot;sched_get_priority_min_args&quot;, &quot;%s(%#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 581, &quot;sched_getcpu_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 328, &quot;sched_getparam_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 330, &quot;sched_getscheduler_args&quot;, &quot;%s(%#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 334, &quot;sched_rr_get_interval_args&quot;, &quot;%s(%#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 327, &quot;sched_setparam_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 329, &quot;sched_setscheduler_args&quot;, &quot;%s(%#x, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 331, &quot;sched_yield_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 474, &quot;sctp_generic_recvmsg_args&quot;, &quot;%s(%#x, %#x, %#x,=
 %#x, %#x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 472, &quot;sctp_generic_sendmsg_args&quot;, &quot;%s(%#x, %#x, %#x,=
 %#x, %#x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 473, &quot;sctp_generic_sendmsg_iov_args&quot;, &quot;%s(%#x, %#x, =
%#x, %#x, %#x, %#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 471, &quot;sctp_peeloff_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 93, &quot;select_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 221, &quot;semget_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 222, &quot;semop_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 169, &quot;semsys_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)&quo=
t;, NULL, NULL },<br>
&gt; +{ 393, &quot;sendfile_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %=
#x, %#x)&quot;, NULL, NULL },<br>
&gt; +{ 28, &quot;sendmsg_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 133, &quot;sendto_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x=
)&quot;, NULL, NULL },<br>
&gt; +{ 452, &quot;setaudit_addr_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 450, &quot;setaudit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 448, &quot;setauid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 422, &quot;setcontext_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 591, &quot;setcred_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 182, &quot;setegid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 183, &quot;seteuid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 175, &quot;setfib_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 181, &quot;setgid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br=
>
&gt; +{ 596, &quot;setgroups_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 83, &quot;setitimer_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 50, &quot;setlogin_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<b=
r>
&gt; +{ 524, &quot;setloginclass_args&quot;, &quot;%s(%#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 82, &quot;setpgid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 96, &quot;setpriority_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 127, &quot;setregid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 312, &quot;setresgid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 311, &quot;setresuid_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 126, &quot;setreuid_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 195, &quot;setrlimit_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NU=
LL },<br>
&gt; +{ 147, &quot;setsid_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 105, &quot;setsockopt_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 122, &quot;settimeofday_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 23, &quot;setuid_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 571, &quot;shm_open2_args&quot;, &quot;%s(%#x, %#x, %o, %#x, %#x)&q=
uot;, NULL, NULL },<br>
&gt; +{ 572, &quot;shm_rename_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 483, &quot;shm_unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 228, &quot;shmat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 512, &quot;shmctl_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 230, &quot;shmdt_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 231, &quot;shmget_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 171, &quot;shmsys_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 134, &quot;shutdown_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 416, &quot;sigaction_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 53, &quot;sigaltstack_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 573, &quot;sigfastblock_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 343, &quot;sigpending_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 340, &quot;sigprocmask_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, N=
ULL, NULL },<br>
&gt; +{ 456, &quot;sigqueue_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 417, &quot;sigreturn_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },=
<br>
&gt; +{ 341, &quot;sigsuspend_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL }=
,<br>
&gt; +{ 345, &quot;sigtimedwait_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, =
NULL, NULL },<br>
&gt; +{ 429, &quot;sigwait_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 346, &quot;sigwaitinfo_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 97, &quot;socket_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, N=
ULL },<br>
&gt; +{ 135, &quot;socketpair_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot=
;, NULL, NULL },<br>
&gt; +{ 555, &quot;statfs_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 423, &quot;swapcontext_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 582, &quot;swapoff_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 85, &quot;swapon_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 57, &quot;symlink_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 502, &quot;symlinkat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 36, &quot;sync_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 165, &quot;sysarch_args&quot;, &quot;%s(%#x, %s)&quot;, NULL, NULL =
},<br>
&gt; +{ 430, &quot;thr_create_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 431, &quot;thr_exit_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 481, &quot;thr_kill2_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 433, &quot;thr_kill_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 455, &quot;thr_new_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 432, &quot;thr_self_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 464, &quot;thr_set_name_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL,=
 NULL },<br>
&gt; +{ 442, &quot;thr_suspend_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 443, &quot;thr_wake_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 585, &quot;timerfd_create_args&quot;, &quot;%s(%#x, %#x)&quot;, NUL=
L, NULL },<br>
&gt; +{ 586, &quot;timerfd_gettime_args&quot;, &quot;%s(%#x, %#x)&quot;, NU=
LL, NULL },<br>
&gt; +{ 587, &quot;timerfd_settime_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 479, &quot;truncate_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 60, &quot;umask_args&quot;, &quot;%s(%o)&quot;, NULL, NULL },<br>
&gt; +{ 205, &quot;undelete_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<=
br>
&gt; +{ 10, &quot;unlink_args&quot;, &quot;%s(%#x)&quot;, NULL, NULL },<br>
&gt; +{ 503, &quot;unlinkat_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 22, &quot;unmount_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 547, &quot;utimensat_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;=
, NULL, NULL },<br>
&gt; +{ 138, &quot;utimes_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 335, &quot;utrace_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL =
},<br>
&gt; +{ 392, &quot;uuidgen_args&quot;, &quot;%s(%#x, %#x)&quot;, NULL, NULL=
 },<br>
&gt; +{ 66, &quot;vfork_args&quot;, NULL, NULL, NULL },<br>
&gt; +{ 7, &quot;wait4_args&quot;, &quot;%s(%#x, %#x, %#x, %#x)&quot;, NULL=
, NULL },<br>
&gt; +{ 532, &quot;wait6_args&quot;, &quot;%s(%#x, %#x, %#x, %#x, %#x, %#x)=
&quot;, NULL, NULL },<br>
&gt; +{ 4, &quot;write_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, NUL=
L },<br>
&gt; +{ 121, &quot;writev_args&quot;, &quot;%s(%#x, %#x, %#x)&quot;, NULL, =
NULL },<br>
&gt; +{ 321, &quot;yield_args&quot;, NULL, NULL, NULL },<br>
&gt; <br>
&gt; -- <br>
&gt; 2.52.0<br>
&gt; <br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--0000000000006426370650b8c8f3--

