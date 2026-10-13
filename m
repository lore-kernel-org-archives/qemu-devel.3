Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33555CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiTa-00017U-Ek; Tue, 13 Oct 2026 15:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xGiTZ-000174-8g
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xGiTW-0001ae-7g
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791920869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U8hRrQsOM/gm1SUQeI3VHH+cSm1E5jLdpCsR4dWM8Qs=;
 b=Ee0AieUuITuevekXsLmaxVUmhH2iGRHG8YfD4fAg/7tPKnBhaW7supCpbozJXIr6u9o9R8
 ZC3ODdDelcy5ipFY4JT6/nPvuAOdG2VJgn/2pO9+GhXgr1Yar72U5vejqnTgJ9/niL6VTv
 VF1/hExDcSKxrwStVZmfj9S5iR+KJuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-MNVBhZVcNHeIQE2WF6dWnQ-1; Tue, 13 Oct 2026 19:47:39 +0000
X-MC-Unique: MNVBhZVcNHeIQE2WF6dWnQ-1
X-Mimecast-MFC-AGG-ID: MNVBhZVcNHeIQE2WF6dWnQ_1791920858
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48afcecb035so968511f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791920858; cv=none;
 d=google.com; s=arc-20260327;
 b=db6DMM5Se560L9HnQXU3xu5L0+BXAE/VY4AHSZNt/0yHoHGlJmGHA7xV8xHNjaqbGQ
 ngVjBqIyF6vje1fzwWeHLYNmxkNWzWiM8ByeDmuFr5wkF0lSUdyaMZt4v5IZJw6PqedG
 /OPMxp3yKW3tos+undzKEXJlbXxbSLzmhakJ9IIix6MPA9uQHmytGi6xxfE8xfN2IZqL
 CICKMUh4egwMMQCp/Kbxy5Xfn3R/RZ2A4iXNM0f1jQqEtskp4DgRgq9q22T9NLcb8AI8
 dKYCwuP94/SDauIEC87M76hP3a/vHso4t6tLwzuH5j7yeef5aDam1OezTGxnGJQnFCz0
 Og/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U8hRrQsOM/gm1SUQeI3VHH+cSm1E5jLdpCsR4dWM8Qs=;
 fh=Zs7uCudbJh/5lmx2GBKg6kzS3TgeNAOJWgopUw3uvWc=;
 b=ItFWtvfJTEH09JdNObqK0t8tFjhVJnD3yVMnmJuvDfqL6z1AzknKASHBV5nl2bf4lr
 P1pjrGOVyvWCGF72RPMZegb/MZohrNw+br9LpgPwQAAJ4QYcrF9cZCLZYESXs4MmsaS2
 xmqQKIleahrKnzX+AG8B98cVaW6Lg+3zy1bANTSz5hlpK+yHEg03DW8vIb+TA8KFwSk8
 5KNj0RYMoPrRXjbP8dRQVDEkTS/Um4zN9x29jxkRxfdPrFMKkwuZkuqWv8vJti4nmkyw
 f54svOIJIibPViswBu9b7KeLZHTuJUs6+XoOeD3P3uEkrepPsGqq3tL288fTROfyHetC
 4TJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791920858; x=1792525658; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U8hRrQsOM/gm1SUQeI3VHH+cSm1E5jLdpCsR4dWM8Qs=;
 b=ijhsuw/3BMcjDgvISd90YV6ETkjVTqnEWVWK92DetYkq6Gqs9C7XQARyWSgaVYZeAZ
 2YzgGp6ACkL4hVcZ8lM+oaZb1iikV3doyHJZkjVWgQ4s36RN4EMmyUoKeqqTPvQ/k8Rc
 iCvny9seCg8cCziHa2iJ8vx7m6MkGxLLOPuAmuLiv8iMVtkiupvffXKhLkrs7tC6f9Lh
 Yz+CsKUHPkkX7ixUbNMjskF1TkYNItv4bUsPJdS+DrnNe9maaWUAQYLA9ZmMfJg8hsTb
 gxBsAPykME7zFIQPgtuti945UhE6l3C0qTSts82pcR8jvH+2KeIoVUJekTuDoYiyn73q
 JUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791920858; x=1792525658;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U8hRrQsOM/gm1SUQeI3VHH+cSm1E5jLdpCsR4dWM8Qs=;
 b=N0ukMN4mWrPM+E9tTiR4L+LdCaRf1U0fg3sJmevsa5vJ6ksbh4HSmZ7BpssalwzF8H
 gRL0cya+kVSkmGr4cteLvf8cKQNNavFDRUIv5M0LqV/zY7Ktnsk93wq93EaCKHbnxMaE
 62mDLvJeq3XU1BB/WsZG7pCPtzgp7LSeI5FagjHBSt0GMHynzcq4PAhH4XbpG6lF8AXl
 H4rJwybNnOQNfbyBPBKtBAc8uUpYYD7ZEU5A38imQu+vTi7CRQqSUh4m5DdIiRAvnBYp
 K0i0Pm229p0sZq6NAJc1jHEjP65Xg187M8tNQRzLrCZ1FWfNT9qbKH9itetBehByyS6W
 5+sw==
X-Gm-Message-State: AFq9FYIMPqMPXdc8o6c2yuck+p5kFTVpeks9PygHE3KtBRzrttu15G34
 Q7YNIddsWDuof0yjRxxS+nJGbLqUw9zbEnH7HCPlrrY74KFsQChCfTETLurmDlsfkT0xPtPf6RT
 7yvZlXt9YINy2wqYqZx5VJ8ag7qYVKZPyk9HE7iovLRJmKS24uXxKOibUGq0ZRk7G91Cs1bPDQz
 1ec9d8M58QnigqDe1kGyNvuadGlGPm9r8=
X-Gm-Gg: AYBFou3pBO+Ql7EFouvPvLU0w4v7z9qTeyptSjWFLX6GZLOy1melt3GI30PW69OGt3o
 UZ2+mzFjsC2npb3/9jOJMpwSugcEuUxnQJmrvLMch4bfJ79q8T6F1wzspAc/MJe0dHDS9ZsG9T2
 CzlW3QJUVYm7TsLbL3wLNGJcvJNd4FTmgO7wgtxBe7wpweZoeb+uKpYJnSWonTG5BvIXYIF4u/z
 ABdm/d/Jvxsjn8gn5wN4Y9pdDfAsmLnxluaw2kPr2azyJu7155TrN94DcuFAQ==
X-Received: by 2002:adf:f94e:0:b0:487:f31:857f with SMTP id
 ffacd0b85a97d-48dbaaed855mr20660252f8f.15.1791920858159; 
 Tue, 13 Oct 2026 12:47:38 -0700 (PDT)
X-Received: by 2002:adf:f94e:0:b0:487:f31:857f with SMTP id
 ffacd0b85a97d-48dbaaed855mr20660213f8f.15.1791920857654; Tue, 13 Oct 2026
 12:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261013181752.1299456-1-stefanha@redhat.com>
 <20261013181752.1299456-5-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-5-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Oct 2026 21:47:25 +0200
X-Gm-Features: AclHuK_eHj1k4jxWP35e2OK5amSzQTZAOyziak1Va448Tag1wm6hctf63S460xA
Message-ID: <CABgObfY3kKXCc4p_qxtOqQ=+NfBw3K=eJ5_+jd=LzCkMXgO6kg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] qemu-pr-helper: add PR_HELPER_CLEANUP for live
 migration
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alex Kalenyuk <akalenyu@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 "Blake, Eric" <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fam Zheng <fam@euphon.net>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002fc026065dbe16b4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000002fc026065dbe16b4
Content-Type: text/plain; charset="UTF-8"

Il mar 13 ott 2026, 20:18 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Introduce a new vendor-specific SCSI command that acts similar to
> REGISTER AND IGNORE EXISTING KEY but also discards multipathd's state
> (including /etc/multipath/prkeys). This command will be used on the
> source after live migration completes successfully.
>
> This cleanup step is necessary because multipathd will register the key
> it has stored when the path comes up again. This is undesirable when the
> guest has migrated to another host and can interfere with the migration
> process or the application running inside the guest.
>
> Add a qemu-pr-manager protocol feature bit indicating that the new
> PR_HELPER_CLEANUP command is available. The command has no CDB fields
> other than OPCODE and the response contains no data aside from the usual
> result and sense data.
>
> Note that the linker needs an explicit libmpathcmd dependency for
> mpath_disconnect() even though qemu-pr-helper.c already #included the
> mpath_cmd.h header before.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>

Thanks, can you also document the changes in  docs/interop/pr-helper.rst
(no need for V3, can be a separate posting or a "patch 9 of 8")? Otherwise
it's all good, thanks!

Paolo

---
> v2:
> - Explicitly reject PR_HELPER_CLEAN commands in scsi_req_new() because
>   this is an internal command that guests cannot send
> - Add missing "forget" in comment (typo)
> ---
>  meson.build              |   2 +
>  include/scsi/constants.h |   1 +
>  scsi/pr-helper.h         |   3 +
>  hw/scsi/scsi-bus.c       |  10 +++
>  scsi/qemu-pr-helper.c    | 146 ++++++++++++++++++++++++++++++++++++---
>  5 files changed, 153 insertions(+), 9 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 48da6cf3e6b..6176935082b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1486,6 +1486,8 @@ if host_os == 'linux' and have_tools and
> get_option('mpath').allowed()
>      endif
>      mpathlibs += cc.find_library('multipath',
>                                   required: get_option('mpath'))
> +    mpathlibs += cc.find_library('mpathcmd',
> +                                 required: get_option('mpath'))
>      foreach lib: mpathlibs
>        if not lib.found()
>          mpathlibs = []
> diff --git a/include/scsi/constants.h b/include/scsi/constants.h
> index 717e470a5d4..bb3981a779b 100644
> --- a/include/scsi/constants.h
> +++ b/include/scsi/constants.h
> @@ -149,6 +149,7 @@
>  #define MECHANISM_STATUS      0xbd
>  #define READ_CD               0xbe
>  #define SEND_DVD_STRUCTURE    0xbf
> +#define PR_HELPER_CLEANUP     0xff /* vendor-specific QEMU command */
>
>  /*
>   * SERVICE ACTION IN subcodes
> diff --git a/scsi/pr-helper.h b/scsi/pr-helper.h
> index e26e104ec76..d088d0dc193 100644
> --- a/scsi/pr-helper.h
> +++ b/scsi/pr-helper.h
> @@ -31,6 +31,9 @@
>  #define PR_HELPER_SENSE_SIZE   96
>  #define PR_HELPER_DATA_SIZE    8192
>
> +/* Protocol features */
> +#define PR_HELPER_FEATURE_CLEANUP (1u << 0)
> +
>  typedef struct PRHelperResponse {
>      int32_t result;
>      int32_t sz;
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index aa02ff631b7..b4c38c083e1 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -873,6 +873,16 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t
> tag, uint32_t lun,
>            */
>           !(buf[0] == REQUEST_SENSE && d->sense_is_ua))) {
>          ops = &reqops_unit_attention;
> +    } else if (buf[0] == PR_HELPER_CLEANUP) {
> +        /*
> +         * This is a QEMU-internal vendor-specific SCSI command that must
> only
> +         * be submitted directly via blk_aio_ioctl() and not through SCSI
> +         * emulation. Reject the command explicitly to guarantee a guest
> cannot
> +         * execute it, although vendor-specific commands are not
> supported by
> +         * SCSI emulation (including passthrough) anyway.
> +         */
> +        trace_scsi_req_parse_bad(d->id, lun, tag, buf[0]);
> +        goto invalid_opcode;
>      } else if (lun != d->lun ||
>                 buf[0] == REPORT_LUNS ||
>                 (buf[0] == REQUEST_SENSE && d->sense_len)) {
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 9dcd3ec7111..54d196a503f 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -537,6 +537,110 @@ static int coroutine_fn multipath_pr_out(int fd,
> const uint8_t *cdb, uint8_t *se
>                                       paramp, noisy, verbose);
>      return mpath_reconstruct_sense(fd, r, sense);
>  }
> +
> +/* Get the device-mapper device name given its block device fd */
> +static char *get_dm_name(int fd, Error **errp)
> +{
> +    struct stat st;
> +    int ret;
> +
> +    assert(is_mpath(fd));
> +
> +    ret = fstat(fd, &st);
> +    if (ret != 0) {
> +        error_setg_errno(errp, errno, "fstat failed on fd %d", fd);
> +        return NULL;
> +    }
> +
> +    return g_strdup_printf("dm-%u", minor(st.st_rdev));
> +}
> +
> +/* Perform a multipathd command */
> +static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
> +{
> +    const unsigned int timeout_ms = 60000;
> +    char *reply = NULL;
> +    int last_errno;
> +    int ret;
> +
> +    ret = mpath_process_cmd(fd, cmd, &reply, timeout_ms);
> +    last_errno = errno;
> +    if (reply && strcmp(reply, "ok\n") != 0) {
> +        error_setg(errp, "mpath_process_cmd(%d, \"%s\") replied \"%s\"",
> +                   fd, cmd, reply);
> +        free(reply);
> +        return false;
> +    }
> +    free(reply);
> +    if (ret == -1) {
> +        error_setg_errno(errp, last_errno,
> +                         "mpath_process_cmd(%d, \"%s\") failed",
> +                         fd, cmd);
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/* Unregister so this I_T nexus has no key registered anymore */
> +static int coroutine_fn multipath_pr_cleanup_unregister(int fd, uint8_t
> *sense,
> +                                                        Error **errp)
> +{
> +    uint8_t cdb[PR_HELPER_CDB_SIZE] = {};
> +    uint8_t param[PR_OUT_FIXED_PARAM_SIZE] = {};
> +
> +    /* Fill in CDB */
> +    cdb[0] = PERSISTENT_RESERVE_OUT;               /* OPERATION CODE */
> +    cdb[1] = PRO_REGISTER_AND_IGNORE_EXISTING_KEY; /* SERVICE ACTION */
> +    stl_be_p(&cdb[5], sizeof(param));              /* PARAMETER LIST
> LENGTH */
> +
> +    /* The parameter list is all zeroes, so there is nothing to fill in */
> +
> +    return multipath_pr_out(fd, cdb, sense, param, sizeof(param));
> +}
> +
> +/*
> + * A special version of REGISTER AND IGNORE EXISTING KEY with sark=0 to
> + * unregister the key without triggering multipathd's preemption. This
> succeeds
> + * when no key is registered too. This is essential so the migration
> source
> + * cleans up its registered key without multipathd preempting the
> destination
> + * host.
> + */
> +static int coroutine_fn multipath_pr_cleanup(int bdev_fd, uint8_t *sense,
> +                                             Error **errp)
> +{
> +    g_autofree char *bdev_dm_name = get_dm_name(bdev_fd, errp);
> +    g_autofree char *cmd = NULL;
> +    int multipathd_fd;
> +
> +    if (bdev_dm_name == NULL) {
> +        return -1;
> +    }
> +
> +    /* First make multipathd forget the key and reservation state */
> +    multipathd_fd = mpath_connect();
> +    if (multipathd_fd == -1) {
> +        error_setg_errno(errp, errno, "mpath_connect() failed");
> +        return -1;
> +    }
> +
> +    cmd = g_strdup_printf("unsetprkey map %s", bdev_dm_name);
> +    if (!multipathd_cmd(multipathd_fd, cmd, errp)) {
> +        mpath_disconnect(multipathd_fd);
> +        return -1;
> +    }
> +
> +    g_free(cmd);
> +    cmd = g_strdup_printf("unsetprstatus map %s", bdev_dm_name);
> +    if (!multipathd_cmd(multipathd_fd, cmd, errp)) {
> +        mpath_disconnect(multipathd_fd);
> +        return -1;
> +    }
> +
> +    mpath_disconnect(multipathd_fd);
> +
> +    /* Now unregister the key at the SCSI level */
> +    return multipath_pr_cleanup_unregister(bdev_fd, sense, errp);
> +}
>  #endif
>
>  static int coroutine_fn do_pr_in(int fd, const uint8_t *cdb, uint8_t
> *sense,
> @@ -578,6 +682,21 @@ static int coroutine_fn do_pr_out(int fd, const
> uint8_t *cdb, uint8_t *sense,
>                     SG_DXFER_TO_DEV);
>  }
>
> +static int coroutine_fn do_pr_cleanup(int fd, uint8_t *sense, Error
> **errp)
> +{
> +    if ((fcntl(fd, F_GETFL) & O_ACCMODE) == O_RDONLY) {
> +        scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
> +        return CHECK_CONDITION;
> +    }
> +
> +#ifdef CONFIG_MPATH
> +    if (is_mpath(fd)) {
> +        return multipath_pr_cleanup(fd, sense, errp);
> +    }
> +#endif
> +    return GOOD;
> +}
> +
>  /* Client */
>
>  typedef struct PRHelperClient {
> @@ -667,7 +786,8 @@ static int coroutine_fn
> prh_read_request(PRHelperClient *client,
>      }
>
>      if (req->cdb[0] != PERSISTENT_RESERVE_OUT &&
> -        req->cdb[0] != PERSISTENT_RESERVE_IN) {
> +        req->cdb[0] != PERSISTENT_RESERVE_IN &&
> +        req->cdb[0] != PR_HELPER_CLEANUP) {
>          error_setg(errp, "Invalid CDB, closing socket.");
>          goto out_close;
>      }
> @@ -703,7 +823,8 @@ static int coroutine_fn
> prh_write_response(PRHelperClient *client,
>      ssize_t r;
>      size_t sz;
>
> -    if (req->cdb[0] == PERSISTENT_RESERVE_IN && resp->result == GOOD) {
> +    if (req->cdb[0] == PERSISTENT_RESERVE_IN &&
> +        resp->result == GOOD) {
>          assert(resp->sz <= req->sz && resp->sz <= sizeof(client->data));
>      } else {
>          assert(resp->sz == 0);
> @@ -739,10 +860,8 @@ static void coroutine_fn prh_co_entry(void *opaque)
>
>      qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
>
> -    /* A very simple negotiation for future extensibility.  No features
> -     * are defined so write 0.
> -     */
> -    flags = cpu_to_be32(0);
> +    /* A very simple negotiation for future extensibility */
> +    flags = cpu_to_be32(PR_HELPER_FEATURE_CLEANUP);
>      r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
>                               (char *) &flags, sizeof(flags), NULL);
>      if (r < 0) {
> @@ -751,7 +870,7 @@ static void coroutine_fn prh_co_entry(void *opaque)
>
>      r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
>                               (char *) &flags, sizeof(flags), NULL);
> -    if (be32_to_cpu(flags) != 0 || r < 0) {
> +    if ((be32_to_cpu(flags) & ~PR_HELPER_FEATURE_CLEANUP) != 0 || r < 0) {
>          goto out;
>      }
>
> @@ -766,15 +885,24 @@ static void coroutine_fn prh_co_entry(void *opaque)
>          }
>
>          num_active_sockets++;
> -        if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
> +        switch (req.cdb[0]) {
> +        case PERSISTENT_RESERVE_OUT:
>              r = do_pr_out(req.fd, req.cdb, resp.sense,
>                            client->data, sz);
>              resp.sz = 0;
> -        } else {
> +            break;
> +        case PERSISTENT_RESERVE_IN:
>              resp.sz = sizeof(client->data);
>              r = do_pr_in(req.fd, req.cdb, resp.sense,
>                           client->data, &resp.sz);
>              resp.sz = MIN(resp.sz, sz);
> +            break;
> +        case PR_HELPER_CLEANUP:
> +            r = do_pr_cleanup(req.fd, resp.sense, &local_err);
> +            resp.sz = 0;
> +            break;
> +        default:
> +            abort();
>          }
>          num_active_sockets--;
>          close(req.fd);
> --
> 2.56.0
>
>

--0000000000002fc026065dbe16b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 13 ott 2026, 20:18 Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Introduce a new vendor-specific SCSI command that acts similar to<br>
REGISTER AND IGNORE EXISTING KEY but also discards multipathd&#39;s state<b=
r>
(including /etc/multipath/prkeys). This command will be used on the<br>
source after live migration completes successfully.<br>
<br>
This cleanup step is necessary because multipathd will register the key<br>
it has stored when the path comes up again. This is undesirable when the<br=
>
guest has migrated to another host and can interfere with the migration<br>
process or the application running inside the guest.<br>
<br>
Add a qemu-pr-manager protocol feature bit indicating that the new<br>
PR_HELPER_CLEANUP command is available. The command has no CDB fields<br>
other than OPCODE and the response contains no data aside from the usual<br=
>
result and sense data.<br>
<br>
Note that the linker needs an explicit libmpathcmd dependency for<br>
mpath_disconnect() even though qemu-pr-helper.c already #included the<br>
mpath_cmd.h header before.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks, can =
you also document the changes in=C2=A0 docs/interop/pr-helper.rst (no need =
for V3, can be a separate posting or a &quot;patch 9 of 8&quot;)? Otherwise=
 it&#39;s all good, thanks!</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
v2:<br>
- Explicitly reject PR_HELPER_CLEAN commands in scsi_req_new() because<br>
=C2=A0 this is an internal command that guests cannot send<br>
- Add missing &quot;forget&quot; in comment (typo)<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +<br>
=C2=A0include/scsi/constants.h |=C2=A0 =C2=A01 +<br>
=C2=A0scsi/pr-helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<b=
r>
=C2=A0hw/scsi/scsi-bus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +++<br>
=C2=A0scsi/qemu-pr-helper.c=C2=A0 =C2=A0 | 146 ++++++++++++++++++++++++++++=
++++++++---<br>
=C2=A05 files changed, 153 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 48da6cf3e6b..6176935082b 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1486,6 +1486,8 @@ if host_os =3D=3D &#39;linux&#39; and have_tools and =
get_option(&#39;mpath&#39;).allowed()<br>
=C2=A0 =C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0 =C2=A0mpathlibs +=3D cc.find_library(&#39;multipath&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required: get_option(&#39;mpa=
th&#39;))<br>
+=C2=A0 =C2=A0 mpathlibs +=3D cc.find_library(&#39;mpathcmd&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_option(&#39;mpat=
h&#39;))<br>
=C2=A0 =C2=A0 =C2=A0foreach lib: mpathlibs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if not lib.found()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mpathlibs =3D []<br>
diff --git a/include/scsi/constants.h b/include/scsi/constants.h<br>
index 717e470a5d4..bb3981a779b 100644<br>
--- a/include/scsi/constants.h<br>
+++ b/include/scsi/constants.h<br>
@@ -149,6 +149,7 @@<br>
=C2=A0#define MECHANISM_STATUS=C2=A0 =C2=A0 =C2=A0 0xbd<br>
=C2=A0#define READ_CD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00xbe<br>
=C2=A0#define SEND_DVD_STRUCTURE=C2=A0 =C2=A0 0xbf<br>
+#define PR_HELPER_CLEANUP=C2=A0 =C2=A0 =C2=A00xff /* vendor-specific QEMU =
command */<br>
<br>
=C2=A0/*<br>
=C2=A0 * SERVICE ACTION IN subcodes<br>
diff --git a/scsi/pr-helper.h b/scsi/pr-helper.h<br>
index e26e104ec76..d088d0dc193 100644<br>
--- a/scsi/pr-helper.h<br>
+++ b/scsi/pr-helper.h<br>
@@ -31,6 +31,9 @@<br>
=C2=A0#define PR_HELPER_SENSE_SIZE=C2=A0 =C2=A096<br>
=C2=A0#define PR_HELPER_DATA_SIZE=C2=A0 =C2=A0 8192<br>
<br>
+/* Protocol features */<br>
+#define PR_HELPER_FEATURE_CLEANUP (1u &lt;&lt; 0)<br>
+<br>
=C2=A0typedef struct PRHelperResponse {<br>
=C2=A0 =C2=A0 =C2=A0int32_t result;<br>
=C2=A0 =C2=A0 =C2=A0int32_t sz;<br>
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c<br>
index aa02ff631b7..b4c38c083e1 100644<br>
--- a/hw/scsi/scsi-bus.c<br>
+++ b/hw/scsi/scsi-bus.c<br>
@@ -873,6 +873,16 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag,=
 uint32_t lun,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(buf[0] =3D=3D REQUEST_SENSE &amp;&amp;=
 d-&gt;sense_is_ua))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ops =3D &amp;reqops_unit_attention;<br>
+=C2=A0 =C2=A0 } else if (buf[0] =3D=3D PR_HELPER_CLEANUP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This is a QEMU-internal vendor-specifi=
c SCSI command that must only<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* be submitted directly via blk_aio_ioct=
l() and not through SCSI<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* emulation. Reject the command explicit=
ly to guarantee a guest cannot<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* execute it, although vendor-specific c=
ommands are not supported by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* SCSI emulation (including passthrough)=
 anyway.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_scsi_req_parse_bad(d-&gt;id, lun, tag, b=
uf[0]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto invalid_opcode;<br>
=C2=A0 =C2=A0 =C2=A0} else if (lun !=3D d-&gt;lun ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[0] =3D=3D REPOR=
T_LUNS ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (buf[0] =3D=3D REQU=
EST_SENSE &amp;&amp; d-&gt;sense_len)) {<br>
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c<br>
index 9dcd3ec7111..54d196a503f 100644<br>
--- a/scsi/qemu-pr-helper.c<br>
+++ b/scsi/qemu-pr-helper.c<br>
@@ -537,6 +537,110 @@ static int coroutine_fn multipath_pr_out(int fd, cons=
t uint8_t *cdb, uint8_t *se<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paramp, noisy, =
verbose);<br>
=C2=A0 =C2=A0 =C2=A0return mpath_reconstruct_sense(fd, r, sense);<br>
=C2=A0}<br>
+<br>
+/* Get the device-mapper device name given its block device fd */<br>
+static char *get_dm_name(int fd, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 struct stat st;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 assert(is_mpath(fd));<br>
+<br>
+=C2=A0 =C2=A0 ret =3D fstat(fd, &amp;st);<br>
+=C2=A0 =C2=A0 if (ret !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;fstat fail=
ed on fd %d&quot;, fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return g_strdup_printf(&quot;dm-%u&quot;, minor(st.st_rdev))=
;<br>
+}<br>
+<br>
+/* Perform a multipathd command */<br>
+static bool multipathd_cmd(int fd, const char *cmd, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const unsigned int timeout_ms =3D 60000;<br>
+=C2=A0 =C2=A0 char *reply =3D NULL;<br>
+=C2=A0 =C2=A0 int last_errno;<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D mpath_process_cmd(fd, cmd, &amp;reply, timeout_ms);<=
br>
+=C2=A0 =C2=A0 last_errno =3D errno;<br>
+=C2=A0 =C2=A0 if (reply &amp;&amp; strcmp(reply, &quot;ok\n&quot;) !=3D 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;mpath_process_cmd(%d, \=
&quot;%s\&quot;) replied \&quot;%s\&quot;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd, c=
md, reply);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(reply);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(reply);<br>
+=C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, last_errno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;mpath_process_cmd(%d, \&quot;%s\&quot;) failed&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0fd, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/* Unregister so this I_T nexus has no key registered anymore */<br>
+static int coroutine_fn multipath_pr_cleanup_unregister(int fd, uint8_t *s=
ense,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t cdb[PR_HELPER_CDB_SIZE] =3D {};<br>
+=C2=A0 =C2=A0 uint8_t param[PR_OUT_FIXED_PARAM_SIZE] =3D {};<br>
+<br>
+=C2=A0 =C2=A0 /* Fill in CDB */<br>
+=C2=A0 =C2=A0 cdb[0] =3D PERSISTENT_RESERVE_OUT;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* OPERATION CODE */<br>
+=C2=A0 =C2=A0 cdb[1] =3D PRO_REGISTER_AND_IGNORE_EXISTING_KEY; /* SERVICE =
ACTION */<br>
+=C2=A0 =C2=A0 stl_be_p(&amp;cdb[5], sizeof(param));=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* PARAMETER LIST LENGTH */<br>
+<br>
+=C2=A0 =C2=A0 /* The parameter list is all zeroes, so there is nothing to =
fill in */<br>
+<br>
+=C2=A0 =C2=A0 return multipath_pr_out(fd, cdb, sense, param, sizeof(param)=
);<br>
+}<br>
+<br>
+/*<br>
+ * A special version of REGISTER AND IGNORE EXISTING KEY with sark=3D0 to<=
br>
+ * unregister the key without triggering multipathd&#39;s preemption. This=
 succeeds<br>
+ * when no key is registered too. This is essential so the migration sourc=
e<br>
+ * cleans up its registered key without multipathd preempting the destinat=
ion<br>
+ * host.<br>
+ */<br>
+static int coroutine_fn multipath_pr_cleanup(int bdev_fd, uint8_t *sense,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *bdev_dm_name =3D get_dm_name(bdev_fd, errp)=
;<br>
+=C2=A0 =C2=A0 g_autofree char *cmd =3D NULL;<br>
+=C2=A0 =C2=A0 int multipathd_fd;<br>
+<br>
+=C2=A0 =C2=A0 if (bdev_dm_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* First make multipathd forget the key and reservation stat=
e */<br>
+=C2=A0 =C2=A0 multipathd_fd =3D mpath_connect();<br>
+=C2=A0 =C2=A0 if (multipathd_fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;mpath_conn=
ect() failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cmd =3D g_strdup_printf(&quot;unsetprkey map %s&quot;, bdev_=
dm_name);<br>
+=C2=A0 =C2=A0 if (!multipathd_cmd(multipathd_fd, cmd, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mpath_disconnect(multipathd_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(cmd);<br>
+=C2=A0 =C2=A0 cmd =3D g_strdup_printf(&quot;unsetprstatus map %s&quot;, bd=
ev_dm_name);<br>
+=C2=A0 =C2=A0 if (!multipathd_cmd(multipathd_fd, cmd, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mpath_disconnect(multipathd_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 mpath_disconnect(multipathd_fd);<br>
+<br>
+=C2=A0 =C2=A0 /* Now unregister the key at the SCSI level */<br>
+=C2=A0 =C2=A0 return multipath_pr_cleanup_unregister(bdev_fd, sense, errp)=
;<br>
+}<br>
=C2=A0#endif<br>
<br>
=C2=A0static int coroutine_fn do_pr_in(int fd, const uint8_t *cdb, uint8_t =
*sense,<br>
@@ -578,6 +682,21 @@ static int coroutine_fn do_pr_out(int fd, const uint8_=
t *cdb, uint8_t *sense,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SG_DX=
FER_TO_DEV);<br>
=C2=A0}<br>
<br>
+static int coroutine_fn do_pr_cleanup(int fd, uint8_t *sense, Error **errp=
)<br>
+{<br>
+=C2=A0 =C2=A0 if ((fcntl(fd, F_GETFL) &amp; O_ACCMODE) =3D=3D O_RDONLY) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_build_sense(sense, SENSE_CODE(INVALID_OPC=
ODE));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return CHECK_CONDITION;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#ifdef CONFIG_MPATH<br>
+=C2=A0 =C2=A0 if (is_mpath(fd)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return multipath_pr_cleanup(fd, sense, errp);<=
br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+=C2=A0 =C2=A0 return GOOD;<br>
+}<br>
+<br>
=C2=A0/* Client */<br>
<br>
=C2=A0typedef struct PRHelperClient {<br>
@@ -667,7 +786,8 @@ static int coroutine_fn prh_read_request(PRHelperClient=
 *client,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (req-&gt;cdb[0] !=3D PERSISTENT_RESERVE_OUT &amp;&am=
p;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;cdb[0] !=3D PERSISTENT_RESERVE_IN) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;cdb[0] !=3D PERSISTENT_RESERVE_IN &amp=
;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;cdb[0] !=3D PR_HELPER_CLEANUP) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Invalid CDB, closi=
ng socket.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_close;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -703,7 +823,8 @@ static int coroutine_fn prh_write_response(PRHelperClie=
nt *client,<br>
=C2=A0 =C2=A0 =C2=A0ssize_t r;<br>
=C2=A0 =C2=A0 =C2=A0size_t sz;<br>
<br>
-=C2=A0 =C2=A0 if (req-&gt;cdb[0] =3D=3D PERSISTENT_RESERVE_IN &amp;&amp; r=
esp-&gt;result =3D=3D GOOD) {<br>
+=C2=A0 =C2=A0 if (req-&gt;cdb[0] =3D=3D PERSISTENT_RESERVE_IN &amp;&amp;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resp-&gt;result =3D=3D GOOD) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(resp-&gt;sz &lt;=3D req-&gt;sz &am=
p;&amp; resp-&gt;sz &lt;=3D sizeof(client-&gt;data));<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(resp-&gt;sz =3D=3D 0);<br>
@@ -739,10 +860,8 @@ static void coroutine_fn prh_co_entry(void *opaque)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client=
-&gt;ioc), true);<br>
<br>
-=C2=A0 =C2=A0 /* A very simple negotiation for future extensibility.=C2=A0=
 No features<br>
-=C2=A0 =C2=A0 =C2=A0* are defined so write 0.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 flags =3D cpu_to_be32(0);<br>
+=C2=A0 =C2=A0 /* A very simple negotiation for future extensibility */<br>
+=C2=A0 =C2=A0 flags =3D cpu_to_be32(PR_HELPER_FEATURE_CLEANUP);<br>
=C2=A0 =C2=A0 =C2=A0r =3D qio_channel_write_all(QIO_CHANNEL(client-&gt;ioc)=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char *) &amp;flags, sizeof(flags), NULL);<=
br>
=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
@@ -751,7 +870,7 @@ static void coroutine_fn prh_co_entry(void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0r =3D qio_channel_read_all(QIO_CHANNEL(client-&gt;ioc),=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char *) &amp;flags, sizeof(flags), NULL);<=
br>
-=C2=A0 =C2=A0 if (be32_to_cpu(flags) !=3D 0 || r &lt; 0) {<br>
+=C2=A0 =C2=A0 if ((be32_to_cpu(flags) &amp; ~PR_HELPER_FEATURE_CLEANUP) !=
=3D 0 || r &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -766,15 +885,24 @@ static void coroutine_fn prh_co_entry(void *opaque)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_active_sockets++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (req.cdb[0] =3D=3D PERSISTENT_RESERVE_OUT) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (req.cdb[0]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PERSISTENT_RESERVE_OUT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D do_pr_out(req.fd, req=
.cdb, resp.sense,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0client-&gt;data, sz);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://resp.sz" =
rel=3D"noreferrer noreferrer" target=3D"_blank">resp.sz</a> =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PERSISTENT_RESERVE_IN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://resp.sz" =
rel=3D"noreferrer noreferrer" target=3D"_blank">resp.sz</a> =3D sizeof(clie=
nt-&gt;data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D do_pr_in(req.fd, req.=
cdb, resp.sense,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 client-&gt;data, &amp;<a href=3D"http://resp.sz" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">resp.sz</a>);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://resp.sz" =
rel=3D"noreferrer noreferrer" target=3D"_blank">resp.sz</a> =3D MIN(<a href=
=3D"http://resp.sz" rel=3D"noreferrer noreferrer" target=3D"_blank">resp.sz=
</a>, sz);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PR_HELPER_CLEANUP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D do_pr_cleanup(req.fd, resp=
.sense, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://resp.sz" rel=
=3D"noreferrer noreferrer" target=3D"_blank">resp.sz</a> =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_active_sockets--;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(req.fd);<br>
-- <br>
2.56.0<br>
<br>
</blockquote></div></div></div>

--0000000000002fc026065dbe16b4--


