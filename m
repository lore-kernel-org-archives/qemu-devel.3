Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B23CF54ABC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52b5-0000Py-QY; Tue, 24 Mar 2026 10:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w52b3-0000PE-SD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w52b0-0003ML-I1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774361941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ZD+zgcIA57jEhOpEF1nTIMU99MzhK6Dpt7kff36/eg=;
 b=fTPt3CJNlOXqN9OOmF3Qp5YtUk6DidxBzZ4RecQgm8zSXhnc686QXCFIIYZ/6GyE7YzyTc
 5XVfDgwL6+KZyw7W+LM/qNS/M22NheqZlXsk1uH4ojEkK5WAgce2X/W6gN9XqZ40y8hvKD
 X/PRLxx/HRx2SSoBgcIo52bjT87NP/A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-zxp40eLTOMe0Yq_BvHG70Q-1; Tue, 24 Mar 2026 10:18:59 -0400
X-MC-Unique: zxp40eLTOMe0Yq_BvHG70Q-1
X-Mimecast-MFC-AGG-ID: zxp40eLTOMe0Yq_BvHG70Q_1774361939
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89c4ec516e5so265923266d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774361939; cv=none;
 d=google.com; s=arc-20240605;
 b=U8jFyM94D8u4v+7UCBTwqtdHXa3RK/cghtIEc0kY7KP2DUk+pZgspCMj+tbTrmxUfJ
 BR5nVoVjBrHjoZMrx4/DCEobsF9t2Ycik1X4US1NtWU4goyNh/o81zdKT2GeSIpK3cCa
 sTOmo+5b3V38ky0GozYIuJ16vnQJqzLEoobrM4dKA8MNsRjkJ02dtmM7BEt0PjkEXl5b
 c4RIdBMm25kCLcZs1TxgiPJoQMj7FUt3ySSezyJcIEHtkRhjaaQEZL6DB1tKF32Ggn1x
 AhEwxtQevrP6LXKoP83jFlARFKmC339fd6bmFpOPUkdpBNpPFedownHsCSL98IRvgX8/
 cGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2ZD+zgcIA57jEhOpEF1nTIMU99MzhK6Dpt7kff36/eg=;
 fh=RAGry+DZCm0KYsBob9/wd3f29ojTEILyS3iSrr5IeVI=;
 b=XQffG+QPZBk+HTt52uGjg28m0aZVkI2ql6W2Rll1L8sM78ENiv7EQltqOzWPV5am7r
 UR2kkSB5Yp2WYfn71OkU4Lop83Tj0vkH4lv1pNahrlC9c9A31ZOaQ6PbedQyxAh8iKyJ
 JDjJDjH2EVHMtf3kURIf889izMdcDXUsjg4i/keLCfYGct7ObSEdhBisg3BmZclOVQSC
 mLhYpaD3uSrSLpd2NTrztgyoGLk1Gm8CVFhK5DuNpckvVrdleLbZS2AtoZMel/MlA0xT
 EKo1ZW1Uk0CN+jH/20K+PIRBEoj4x8IOEUzZ4vd8rBOwAMWTAvLZfFj+2jnt1yB3nDU2
 GRBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774361939; x=1774966739; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZD+zgcIA57jEhOpEF1nTIMU99MzhK6Dpt7kff36/eg=;
 b=JJG0NeXdlJ8N1ry4CBGexmeHH7t/0WWfbkhGkyJjCzjXjabA7izYBbfX4zw3mFCHqY
 e9MprjlLpnHq5iMLNjJjtz0sGAgZaHPbHxvCuPiTGrwa1zWliKrBk0l/l4wyrq4VX50o
 tKwdsp30zfVVR+TVMbO0tU6ITOPveA8bHaNMYIVefEDiy6o8ILxPAbhvNsUZOP0/Uuiq
 UtvMBIfHwUXj3kh9XaG4jOKasHv86rNwompMbpx+pAI540By+/+xRMn/f4xLm4H1Hd5n
 Mz7zQEwjgQQuaw7OETsCQAdOYxeL6ogMiArJRKao88wRjGL5KiyTfs98yLo/4naoNo6z
 lTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361939; x=1774966739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZD+zgcIA57jEhOpEF1nTIMU99MzhK6Dpt7kff36/eg=;
 b=nSBKilwqhL7kXdjwvIBf+Z8dbQmhfhKrdiFsd2goJ9H8Lmpm/Kq5DqB/IkSh/vs3qM
 7zojgf+W5u71wVa5xkfZekMNWGEYbHumBIjfGAnjKzc2wYXaLO27jfvAC4nr2emY0Tj/
 qzxaPRpGTlPRW4t0q4HMm27bnwnjF5VeohW7HlU2ml6fKMxMbdN+reiPA+N5k3Oiu9pe
 rxgXM1LRTMeGKHIjBhfyaHODIZttLirw8Cul76GLoz6FZ+ZxrXozrzPU7TVnH5O6kzIw
 3Y80mEwyr/QyYegFVa5NR5l//jomK/0QaDyumsj7eM2mSvN6YLMf6TS1DyBzD0Lbgyfw
 6I9Q==
X-Gm-Message-State: AOJu0Yy94pJ1RknbLEiYSar79X2MTJzKbZJhZzQhBYqJJHj+7tgH6SKH
 FHB4ghwAO0EwGmCjcWN60rn4ccUf1z0NRrWEZCw3Hz42EAUJWUf34OEqmYuLNCViLt9t2HLrTgX
 QzT2mTjZXoDi5buORHEkU8XecEY3aMUrUFCyz2izareO5sW0O34U0ztNIT1LHfpSkSq/J4/6FA3
 s78ajhaYMxGOQJBZ/W+jguvAUru8wHcGY=
X-Gm-Gg: ATEYQzxlxoCN1TdT3SR8gvVcTvlQ95FV5O5oWi2Bv81Wkq19pF/Gu4HnMtmsRFY/uxt
 LC17y6e+A6/ELAD4oBU9hPWILLKKtetz9pUptHV7d+yqmbJ+9RFDZlzmYj+TK6fErTzRqdlDlsd
 /aQqyY+LC5iY/JkrqUOT+vIRtlPnlkwVIKb7ayrAqcho/bL/nlTVXHgllwukwPZJb5w/67ZvHTl
 R3h3pw/
X-Received: by 2002:ad4:5746:0:b0:89c:4d76:d16e with SMTP id
 6a1803df08f44-89c859ccee2mr259706256d6.6.1774361938800; 
 Tue, 24 Mar 2026 07:18:58 -0700 (PDT)
X-Received: by 2002:ad4:5746:0:b0:89c:4d76:d16e with SMTP id
 6a1803df08f44-89c859ccee2mr259705676d6.6.1774361938134; Tue, 24 Mar 2026
 07:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260312141657.1701801-1-eashurov@redhat.com>
 <20260318154752.1880933-1-eashurov@redhat.com>
 <20260318154752.1880933-2-eashurov@redhat.com>
 <CAPMcbCrLQevjUZSMdiSL-ZdMernNzXhGM3NEe8XXgEi-yNx5RQ@mail.gmail.com>
 <CAK957kFBi0LOn2SABHna_4ce2c1x0=4QP10mNut4o=r+wt3dXQ@mail.gmail.com>
In-Reply-To: <CAK957kFBi0LOn2SABHna_4ce2c1x0=4QP10mNut4o=r+wt3dXQ@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 24 Mar 2026 16:18:46 +0200
X-Gm-Features: AQROBzAph_QF1iJ3I0BelyQOqMS6R1t6mIlSqBVsKkF1srQFQ3WrjOtPINCeLN0
Message-ID: <CAPMcbCrWAYhs5v3-kBQC2o5F8v44SKLm-dZJk16j9DAWcuFTug@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qga: add --audit option for command logging control
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, yvugenfi@redhat.com
Content-Type: multipart/alternative; boundary="00000000000006a96d064dc5d524"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000006a96d064dc5d524
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:08=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat.=
com>
wrote:

> Hi,
>
> Thanks for the review. I'm working on v3 and addressed the comments.
>
> Regarding the g_debug lines in guest_exec: I kept them because
> ga_audit_log only logs the command name, while the g_debug lines include
> the arguments (str) and the PID. This was previously logged at info level=
,
> so I wanted to avoid losing that information.
>
> Regarding NULL safety of ga_audit_log: the function itself is not
> NULL-safe, but the current flow does not call it with NULL.
> I will add an explicit check at the beginning of ga_audit_log for safety.
>
> Let me know if you prefer to keep the g_debug lines. Otherwise, I=E2=80=
=99ll
> remove them and send v3.
>
You can keep it


>
> On Mon, Mar 23, 2026 at 3:46=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redh=
at.com>
> wrote:
>
>>
>>
>> On Wed, Mar 18, 2026 at 5:48=E2=80=AFPM Elizabeth Ashurov <eashurov@redh=
at.com>
>> wrote:
>>
>>> Add -A/--audit=3DLIST option to control which guest agent commands
>>> are logged at info level (visible with --verbose) and which at
>>> debug level (visible only with --debug).
>>>
>>> Patterns are comma-separated and checked in order; the first match
>>> wins. Patterns starting with '!' log the command at debug level
>>> instead of info.
>>> For example: --audit=3D!guest-ping,* logs all commands
>>> at info level except guest-ping.
>>>
>>> Move command logging from individual handlers into process_event()
>>> so all commands are logged in one place. Keep g_debug() calls in
>>> handlers for useful details like file paths, handles, and PIDs.
>>>
>>> The default pattern is '*', so all commands are logged at info
>>> level unless configured otherwise.
>>>
>>> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>>> ---
>>>  qga/commands-linux.c |  2 --
>>>  qga/commands-posix.c | 11 +++----
>>>  qga/commands-win32.c | 14 +++------
>>>  qga/commands.c       |  6 ++--
>>>  qga/main.c           | 73 ++++++++++++++++++++++++++++++++++++++++++--
>>>  5 files changed, 81 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>>> index a722de2e6a..8df83963fa 100644
>>> --- a/qga/commands-linux.c
>>> +++ b/qga/commands-linux.c
>>> @@ -1158,8 +1158,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t
>>> minimum, Error **errp)
>>>      int fd;
>>>      struct fstrim_range r;
>>>
>>> -    g_info("guest-fstrim called");
>>> -
>>>      QTAILQ_INIT(&mounts);
>>>      if (!build_fs_mount_list(&mounts, errp)) {
>>>          return NULL;
>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>> index 96939a6f36..6a3e6c78e3 100644
>>> --- a/qga/commands-posix.c
>>> +++ b/qga/commands-posix.c
>>> @@ -240,7 +240,7 @@ void qmp_guest_shutdown(const char *mode, Error
>>> **errp)
>>>      const char *reboot_flag =3D "-r";
>>>  #endif
>>>
>>> -    g_info("guest-shutdown called, mode: %s", mode);
>>> +    g_debug("guest-shutdown mode: %s", mode);
>>>      if (!mode || strcmp(mode, "powerdown") =3D=3D 0) {
>>>          if (access(POWEROFF_CMD_PATH, X_OK) =3D=3D 0) {
>>>              shutdown_cmd =3D POWEROFF_CMD_PATH;
>>> @@ -519,7 +519,7 @@ int64_t qmp_guest_file_open(const char *path, const
>>> char *mode,
>>>      if (!mode) {
>>>          mode =3D "r";
>>>      }
>>> -    g_info("guest-file-open called, filepath: %s, mode: %s", path,
>>> mode);
>>> +    g_debug("guest-file-open filepath: %s, mode: %s", path, mode);
>>>      fh =3D safe_open_or_create(path, mode, &local_err);
>>>      if (local_err !=3D NULL) {
>>>          error_propagate(errp, local_err);
>>> @@ -540,7 +540,7 @@ int64_t qmp_guest_file_open(const char *path, const
>>> char *mode,
>>>          return -1;
>>>      }
>>>
>>> -    g_info("guest-file-open, handle: %" PRId64, handle);
>>> +    g_debug("guest-file-open handle: %" PRId64, handle);
>>>      return handle;
>>>  }
>>>
>>> @@ -549,7 +549,7 @@ void qmp_guest_file_close(int64_t handle, Error
>>> **errp)
>>>      GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
>>>      int ret;
>>>
>>> -    g_info("guest-file-close called, handle: %" PRId64, handle);
>>> +    g_debug("guest-file-close handle: %" PRId64, handle);
>>>      if (!gfh) {
>>>          return;
>>>      }
>>> @@ -793,8 +793,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
>>> has_mountpoints,
>>>      FsMountList mounts;
>>>      Error *local_err =3D NULL;
>>>
>>> -    g_info("guest-fsfreeze called");
>>> -
>>>      execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &local_err);
>>>      if (local_err) {
>>>          error_propagate(errp, local_err);
>>> @@ -833,7 +831,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>>
>>>      if (ret >=3D 0) {
>>>          ga_unset_frozen(ga_state);
>>> -        g_info("guest-fsthaw called");
>>>          execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
>>>      } else {
>>>          ret =3D 0;
>>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>>> index d26b0041ce..e916d081f5 100644
>>> --- a/qga/commands-win32.c
>>> +++ b/qga/commands-win32.c
>>> @@ -231,7 +231,7 @@ int64_t qmp_guest_file_open(const char *path, const
>>> char *mode, Error **errp)
>>>      if (!mode) {
>>>          mode =3D "r";
>>>      }
>>> -    g_info("guest-file-open called, filepath: %s, mode: %s", path,
>>> mode);
>>> +    g_debug("guest-file-open filepath: %s, mode: %s", path, mode);
>>>      guest_flags =3D find_open_flag(mode);
>>>      if (guest_flags =3D=3D NULL) {
>>>          error_setg(errp, "invalid file open mode");
>>> @@ -267,8 +267,7 @@ int64_t qmp_guest_file_open(const char *path, const
>>> char *mode, Error **errp)
>>>          goto done;
>>>      }
>>>
>>> -    g_info("guest-file-open, handle: % " PRId64, fd);
>>> -
>>> +    g_debug("guest-file-open handle: %" PRId64, fd);
>>>  done:
>>>      g_free(w_path);
>>>      return fd;
>>> @@ -278,7 +277,7 @@ void qmp_guest_file_close(int64_t handle, Error
>>> **errp)
>>>  {
>>>      bool ret;
>>>      GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
>>> -    g_info("guest-file-close called, handle: %" PRId64, handle);
>>> +    g_debug("guest-file-close handle: %" PRId64, handle);
>>>      if (gfh =3D=3D NULL) {
>>>          return;
>>>      }
>>> @@ -337,8 +336,7 @@ void qmp_guest_shutdown(const char *mode, Error
>>> **errp)
>>>      Error *local_err =3D NULL;
>>>      UINT shutdown_flag =3D EWX_FORCE;
>>>
>>> -    g_info("guest-shutdown called, mode: %s", mode);
>>> -
>>> +    g_debug("guest-shutdown mode: %s", mode);
>>>      if (!mode || strcmp(mode, "powerdown") =3D=3D 0) {
>>>          shutdown_flag |=3D EWX_POWEROFF;
>>>      } else if (strcmp(mode, "halt") =3D=3D 0) {
>>> @@ -1255,8 +1253,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
>>> has_mountpoints,
>>>          return 0;
>>>      }
>>>
>>> -    g_info("guest-fsfreeze called");
>>> -
>>>      /* cannot risk guest agent blocking itself on a write in this stat=
e
>>> */
>>>      ga_set_frozen(ga_state);
>>>
>>> @@ -1294,8 +1290,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>>>
>>>      ga_unset_frozen(ga_state);
>>>
>>> -    g_info("guest-fsthaw called");
>>> -
>>>      return i;
>>>  }
>>>
>>> diff --git a/qga/commands.c b/qga/commands.c
>>> index 55edd9fd4c..4462922005 100644
>>> --- a/qga/commands.c
>>> +++ b/qga/commands.c
>>> @@ -43,7 +43,6 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)
>>>
>>>  void qmp_guest_ping(Error **errp)
>>>  {
>>> -    g_info("guest-ping called");
>>>  }
>>>
>>>  static void qmp_command_info(const QmpCommand *cmd, void *opaque)
>>> @@ -136,8 +135,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid,
>>> Error **errp)
>>>      GuestExecInfo *gei;
>>>      GuestExecStatus *ges;
>>>
>>> -    g_info("guest-exec-status called, pid: %u", (uint32_t)pid);
>>> -
>>> +    g_debug("guest-exec-status pid: %u", (uint32_t)pid);
>>>
>>
>> any reason for g_debug there? will it be printed by ga_audit_log?
>>
>> in any case, the extra line was removed
>>
>>      gei =3D guest_exec_info_find(pid);
>>>      if (gei =3D=3D NULL) {
>>>          error_setg(errp, "PID " PRId64 " does not exist");
>>> @@ -238,7 +236,7 @@ static char **guest_exec_get_args(const strList
>>> *entry, bool log)
>>>      args[i] =3D NULL;
>>>
>>>      if (log) {
>>> -        g_info("guest-exec called: \"%s\"", str);
>>> +        g_debug("guest-exec called: \"%s\"", str);
>>>
>>
>> the same
>>
>>
>>>      }
>>>      g_free(str);
>>>
>>> diff --git a/qga/main.c b/qga/main.c
>>> index 04c772b680..5b289ae7f9 100644
>>> --- a/qga/main.c
>>> +++ b/qga/main.c
>>> @@ -87,8 +87,10 @@ struct GAConfig {
>>>  #endif
>>>      gchar *bliststr; /* blockedrpcs may point to this string */
>>>      gchar *aliststr; /* allowedrpcs may point to this string */
>>> +    gchar *auditstr;
>>>      GList *blockedrpcs;
>>>      GList *allowedrpcs;
>>> +    GList *audit_patterns;
>>>      int daemonize;
>>>      GLogLevelFlags log_level;
>>>      int dumpconf;
>>> @@ -116,6 +118,7 @@ struct GAState {
>>>      bool frozen;
>>>      GList *blockedrpcs;
>>>      GList *allowedrpcs;
>>> +    GList *audit_patterns;
>>>      char *state_filepath_isfrozen;
>>>      struct {
>>>          const char *log_filepath;
>>> @@ -288,6 +291,11 @@ QEMU_COPYRIGHT "\n"
>>>  "                    only, default is %s)\n"
>>>  "  -v, --verbose     enable verbose logging (warning/info and above)\n=
"
>>>  "  -g, --debug       enable debug logging (all messages)\n"
>>> +"  -A, --audit=3DLIST  comma-separated list of command patterns to log
>>> at\n"
>>> +"                    info level (default: *, no spaces).\n"
>>> +"                    Patterns prefixed with '!' are logged at debug
>>> level.\n"
>>> +"                    Patterns are evaluated in order; the first match
>>> wins.\n"
>>> +"                    Example: --audit=3D!guest-ping,*\n"
>>>  "  -V, --version     print version information and exit\n"
>>>  "  -d, --daemonize   become a daemon\n"
>>>  #ifdef _WIN32
>>> @@ -413,6 +421,29 @@ static void ga_log(const gchar *domain,
>>> GLogLevelFlags level,
>>>      }
>>>  }
>>>
>>> +static void ga_audit_log(GAState *s, const char *command)
>>> +{
>>> +    GList *l;
>>> +
>>> +    for (l =3D s->audit_patterns; l; l =3D l->next) {
>>> +        const char *pattern =3D l->data;
>>> +
>>> +        if (pattern[0] =3D=3D '!') {
>>> +            if (g_pattern_match_simple(pattern + 1, command)) {
>>> +                g_debug("%s called", command);
>>> +                return;
>>> +            }
>>> +        } else {
>>> +            if (g_pattern_match_simple(pattern, command)) {
>>> +                g_info("%s called", command);
>>> +                return;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    g_debug("%s called", command);
>>> +}
>>> +
>>>  void ga_set_response_delimited(GAState *s)
>>>  {
>>>      s->delimit_response =3D true;
>>> @@ -706,7 +737,22 @@ static void process_event(void *opaque, QObject
>>> *obj, Error *err)
>>>      }
>>>
>>>      g_debug("processing command");
>>> -    rsp =3D qmp_dispatch(&ga_commands, obj, false, NULL);
>>> +    {
>>> +        QDict *dict =3D qobject_to(QDict, obj);
>>> +        const char *command =3D dict ? qdict_get_try_str(dict, "execut=
e")
>>> : NULL;
>>> +        bool logging_before =3D ga_logging_enabled(s);
>>>
>>
>> Please add a comment on why we need this.
>> I know about fs-thaw and disabled logging, but for other people, this ca=
n
>> be unclear
>>
>>
>>> +        bool audit =3D command && qmp_find_command(&ga_commands, comma=
nd);
>>> +
>>> +        if (audit) {
>>> +            ga_audit_log(s, command);
>>>
>> What if command =3D NULL? Is ga_audit_log NULL-safe?
>>
>>
>>> +        }
>>> +
>>> +        rsp =3D qmp_dispatch(&ga_commands, obj, false, NULL);
>>> +
>>> +        if (!logging_before && audit) {
>>> +            ga_audit_log(s, command);
>>> +        }
>>> +    }
>>>
>>>  end:
>>>      ret =3D send_response(s, rsp);
>>> @@ -1158,6 +1204,14 @@ static void config_load(GAConfig *config, const
>>> char *confpath, bool required)
>>>          config->retry_path =3D
>>>              g_key_file_get_boolean(keyfile, "general", "retry-path",
>>> &gerr);
>>>      }
>>> +    if (g_key_file_has_key(keyfile, "general", "audit", NULL)) {
>>> +        config->auditstr =3D
>>> +            g_key_file_get_string(keyfile, "general", "audit", &gerr);
>>> +        config->audit_patterns =3D g_list_concat(config->audit_pattern=
s,
>>> +                                               g_list_reverse(
>>> +
>>>  split_list(config->auditstr,
>>> +                                                              ",")));
>>> +    }
>>>
>>>      if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL)) {
>>>          config->bliststr =3D
>>> @@ -1230,6 +1284,9 @@ static void config_dump(GAConfig *config)
>>>                             config->log_level & G_LOG_LEVEL_DEBUG);
>>>      g_key_file_set_boolean(keyfile, "general", "retry-path",
>>>                             config->retry_path);
>>> +    tmp =3D list_join(config->audit_patterns, ',');
>>> +    g_key_file_set_string(keyfile, "general", "audit", tmp);
>>> +    g_free(tmp);
>>>      tmp =3D list_join(config->blockedrpcs, ',');
>>>      g_key_file_set_string(keyfile, "general", "block-rpcs", tmp);
>>>      g_free(tmp);
>>> @@ -1251,7 +1308,7 @@ static void config_dump(GAConfig *config)
>>>
>>>  static void config_parse(GAConfig *config, int argc, char **argv)
>>>  {
>>> -    const char *sopt =3D "hVvdgc:m:p:l:f:F::b:a:s:t:Dr";
>>> +    const char *sopt =3D "hVvdgc:m:p:l:f:F::b:a:A:s:t:Dr";
>>>      int opt_ind =3D 0, ch;
>>>      const struct option lopt[] =3D {
>>>          { "help", 0, NULL, 'h' },
>>> @@ -1270,6 +1327,7 @@ static void config_parse(GAConfig *config, int
>>> argc, char **argv)
>>>          { "daemonize", 0, NULL, 'd' },
>>>          { "block-rpcs", 1, NULL, 'b' },
>>>          { "allow-rpcs", 1, NULL, 'a' },
>>> +        { "audit", 1, NULL, 'A' },
>>>  #ifdef _WIN32
>>>          { "service", 1, NULL, 's' },
>>>  #endif
>>> @@ -1363,6 +1421,10 @@ static void config_parse(GAConfig *config, int
>>> argc, char **argv)
>>>                                                  split_list(optarg,
>>> ","));
>>>              break;
>>>          }
>>> +        case 'A':
>>> +            g_list_free_full(config->audit_patterns, g_free);
>>> +            config->audit_patterns =3D g_list_reverse(split_list(optar=
g,
>>> ","));
>>> +            break;
>>>  #ifdef _WIN32
>>>          case 's':
>>>              config->service =3D optarg;
>>> @@ -1417,6 +1479,8 @@ static void config_free(GAConfig *config)
>>>  #endif
>>>      g_list_free_full(config->blockedrpcs, g_free);
>>>      g_list_free_full(config->allowedrpcs, g_free);
>>> +    g_list_free_full(config->audit_patterns, g_free);
>>> +    g_free(config->auditstr);
>>>      g_free(config);
>>>  }
>>>
>>> @@ -1460,6 +1524,7 @@ static GAState *initialize_agent(GAConfig *config=
,
>>> int socket_activation)
>>>      g_assert(ga_state =3D=3D NULL);
>>>
>>>      s->log_level =3D config->log_level;
>>> +    s->audit_patterns =3D config->audit_patterns;
>>>      s->log_file =3D stderr;
>>>  #ifdef CONFIG_FSFREEZE
>>>      s->fsfreeze_hook =3D config->fsfreeze_hook;
>>> @@ -1698,6 +1763,10 @@ int main(int argc, char **argv)
>>>      init_dfl_pathnames();
>>>      config_parse(config, argc, argv);
>>>
>>> +    if (config->audit_patterns =3D=3D NULL) {
>>> +        config->audit_patterns =3D g_list_append(NULL, g_strdup("*"));
>>> +    }
>>> +
>>>      if (config->pid_filepath =3D=3D NULL) {
>>>          config->pid_filepath =3D g_strdup(dfl_pathnames.pidfile);
>>>      }
>>> --
>>> 2.51.0
>>>
>>>

--00000000000006a96d064dc5d524
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 4:08=E2=80=AFPM Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@r=
edhat.com">eashurov@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<br><br>Thanks for the re=
view. I&#39;m working on v3 and addressed the comments.<br><br>Regarding th=
e g_debug lines in guest_exec: I kept them because ga_audit_log only logs t=
he command name, while the g_debug lines include the arguments (str) and th=
e PID. This was previously logged at info level, so I wanted to avoid losin=
g that information.<br><br>Regarding NULL safety of ga_audit_log: the funct=
ion itself is not NULL-safe, but the current flow does not call it with NUL=
L.<br>I will add an explicit check at the beginning of ga_audit_log for saf=
ety.<br><br>Let me know if you prefer to keep the g_debug lines. Otherwise,=
 I=E2=80=99ll remove them and send v3.<br></div></blockquote><div>You can k=
eep it</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Mar 23, 2026 at 3:46=E2=80=AFPM Kostiantyn Kos=
tiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, M=
ar 18, 2026 at 5:48=E2=80=AFPM Elizabeth Ashurov &lt;<a href=3D"mailto:eash=
urov@redhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Add -A/--audit=3DLIST=
 option to control which guest agent commands<br>
are logged at info level (visible with --verbose) and which at<br>
debug level (visible only with --debug).<br>
<br>
Patterns are comma-separated and checked in order; the first match<br>
wins. Patterns starting with &#39;!&#39; log the command at debug level<br>
instead of info.<br>
For example: --audit=3D!guest-ping,* logs all commands<br>
at info level except guest-ping.<br>
<br>
Move command logging from individual handlers into process_event()<br>
so all commands are logged in one place. Keep g_debug() calls in<br>
handlers for useful details like file paths, handles, and PIDs.<br>
<br>
The default pattern is &#39;*&#39;, so all commands are logged at info<br>
level unless configured otherwise.<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c |=C2=A0 2 --<br>
=C2=A0qga/commands-posix.c | 11 +++----<br>
=C2=A0qga/commands-win32.c | 14 +++------<br>
=C2=A0qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++--<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 73 +++++++++++++=
+++++++++++++++++++++++++++++--<br>
=C2=A05 files changed, 81 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index a722de2e6a..8df83963fa 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1158,8 +1158,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, E=
rror **errp)<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
=C2=A0 =C2=A0 =C2=A0struct fstrim_range r;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fstrim called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;mounts);<br>
=C2=A0 =C2=A0 =C2=A0if (!build_fs_mount_list(&amp;mounts, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 96939a6f36..6a3e6c78e3 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -240,7 +240,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0const char *reboot_flag =3D &quot;-r&quot;;<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-shutdown called, mode: %s&quot;, mode);<b=
r>
+=C2=A0 =C2=A0 g_debug(&quot;guest-shutdown mode: %s&quot;, mode);<br>
=C2=A0 =C2=A0 =C2=A0if (!mode || strcmp(mode, &quot;powerdown&quot;) =3D=3D=
 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(POWEROFF_CMD_PATH, X_OK) =3D=
=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_cmd =3D POWEROFF_C=
MD_PATH;<br>
@@ -519,7 +519,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode,<br>
=C2=A0 =C2=A0 =C2=A0if (!mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D &quot;r&quot;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open called, filepath: %s, mode: %s&=
quot;, path, mode);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open filepath: %s, mode: %s&quot;, =
path, mode);<br>
=C2=A0 =C2=A0 =C2=A0fh =3D safe_open_or_create(path, mode, &amp;local_err);=
<br>
=C2=A0 =C2=A0 =C2=A0if (local_err !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
@@ -540,7 +540,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open, handle: %&quot; PRId64, handle=
);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open handle: %&quot; PRId64, handle=
);<br>
=C2=A0 =C2=A0 =C2=A0return handle;<br>
=C2=A0}<br>
<br>
@@ -549,7 +549,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0GuestFileHandle *gfh =3D guest_file_handle_find(handle,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-close called, handle: %&quot; PRId64=
, handle);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-close handle: %&quot; PRId64, handl=
e);<br>
=C2=A0 =C2=A0 =C2=A0if (!gfh) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -793,8 +793,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpo=
ints,<br>
=C2=A0 =C2=A0 =C2=A0FsMountList mounts;<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fsfreeze called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &amp;local_=
err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
@@ -833,7 +831,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_info(&quot;guest-fsthaw called&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0execute_fsfreeze_hook(FSFREEZE_HOOK_THAW,=
 errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index d26b0041ce..e916d081f5 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -231,7 +231,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0if (!mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D &quot;r&quot;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open called, filepath: %s, mode: %s&=
quot;, path, mode);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open filepath: %s, mode: %s&quot;, =
path, mode);<br>
=C2=A0 =C2=A0 =C2=A0guest_flags =3D find_open_flag(mode);<br>
=C2=A0 =C2=A0 =C2=A0if (guest_flags =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;invalid file open =
mode&quot;);<br>
@@ -267,8 +267,7 @@ int64_t qmp_guest_file_open(const char *path, const cha=
r *mode, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-open, handle: % &quot; PRId64, fd);<=
br>
-<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-open handle: %&quot; PRId64, fd);<b=
r>
=C2=A0done:<br>
=C2=A0 =C2=A0 =C2=A0g_free(w_path);<br>
=C2=A0 =C2=A0 =C2=A0return fd;<br>
@@ -278,7 +277,7 @@ void qmp_guest_file_close(int64_t handle, Error **errp)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool ret;<br>
=C2=A0 =C2=A0 =C2=A0GuestFileHandle *gfh =3D guest_file_handle_find(handle,=
 errp);<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-file-close called, handle: %&quot; PRId64=
, handle);<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-file-close handle: %&quot; PRId64, handl=
e);<br>
=C2=A0 =C2=A0 =C2=A0if (gfh =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -337,8 +336,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)=
<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0UINT shutdown_flag =3D EWX_FORCE;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-shutdown called, mode: %s&quot;, mode);<b=
r>
-<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-shutdown mode: %s&quot;, mode);<br>
=C2=A0 =C2=A0 =C2=A0if (!mode || strcmp(mode, &quot;powerdown&quot;) =3D=3D=
 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_flag |=3D EWX_POWEROFF;<br>
=C2=A0 =C2=A0 =C2=A0} else if (strcmp(mode, &quot;halt&quot;) =3D=3D 0) {<b=
r>
@@ -1255,8 +1253,6 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mount=
points,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fsfreeze called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* cannot risk guest agent blocking itself on a write i=
n this state */<br>
=C2=A0 =C2=A0 =C2=A0ga_set_frozen(ga_state);<br>
<br>
@@ -1294,8 +1290,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0ga_unset_frozen(ga_state);<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-fsthaw called&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0return i;<br>
=C2=A0}<br>
<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index 55edd9fd4c..4462922005 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -43,7 +43,6 @@ int64_t qmp_guest_sync(int64_t id, Error **errp)<br>
<br>
=C2=A0void qmp_guest_ping(Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-ping called&quot;);<br>
=C2=A0}<br>
<br>
=C2=A0static void qmp_command_info(const QmpCommand *cmd, void *opaque)<br>
@@ -136,8 +135,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0GuestExecInfo *gei;<br>
=C2=A0 =C2=A0 =C2=A0GuestExecStatus *ges;<br>
<br>
-=C2=A0 =C2=A0 g_info(&quot;guest-exec-status called, pid: %u&quot;, (uint3=
2_t)pid);<br>
-<br>
+=C2=A0 =C2=A0 g_debug(&quot;guest-exec-status pid: %u&quot;, (uint32_t)pid=
);<br></blockquote><div><br></div><div>any reason for=C2=A0g_debug there? w=
ill it be printed by=C2=A0ga_audit_log?=C2=A0</div><div><br></div><div>in a=
ny case, the extra line was removed</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0gei =3D guest_exec_info_find(pid);<br>
=C2=A0 =C2=A0 =C2=A0if (gei =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;PID &quot; PRId64 =
&quot; does not exist&quot;);<br>
@@ -238,7 +236,7 @@ static char **guest_exec_get_args(const strList *entry,=
 bool log)<br>
=C2=A0 =C2=A0 =C2=A0args[i] =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (log) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_info(&quot;guest-exec called: \&quot;%s\&quo=
t;&quot;, str);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;guest-exec called: \&quot;%s\&qu=
ot;&quot;, str);<br></blockquote><div><br></div><div>the same</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_free(str);<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 04c772b680..5b289ae7f9 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -87,8 +87,10 @@ struct GAConfig {<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0gchar *bliststr; /* blockedrpcs may point to this strin=
g */<br>
=C2=A0 =C2=A0 =C2=A0gchar *aliststr; /* allowedrpcs may point to this strin=
g */<br>
+=C2=A0 =C2=A0 gchar *auditstr;<br>
=C2=A0 =C2=A0 =C2=A0GList *blockedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0GList *allowedrpcs;<br>
+=C2=A0 =C2=A0 GList *audit_patterns;<br>
=C2=A0 =C2=A0 =C2=A0int daemonize;<br>
=C2=A0 =C2=A0 =C2=A0GLogLevelFlags log_level;<br>
=C2=A0 =C2=A0 =C2=A0int dumpconf;<br>
@@ -116,6 +118,7 @@ struct GAState {<br>
=C2=A0 =C2=A0 =C2=A0bool frozen;<br>
=C2=A0 =C2=A0 =C2=A0GList *blockedrpcs;<br>
=C2=A0 =C2=A0 =C2=A0GList *allowedrpcs;<br>
+=C2=A0 =C2=A0 GList *audit_patterns;<br>
=C2=A0 =C2=A0 =C2=A0char *state_filepath_isfrozen;<br>
=C2=A0 =C2=A0 =C2=A0struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *log_filepath;<br>
@@ -288,6 +291,11 @@ QEMU_COPYRIGHT &quot;\n&quot;<br>
=C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 only, default is %s)\n&quot;<br>
=C2=A0&quot;=C2=A0 -v, --verbose=C2=A0 =C2=A0 =C2=A0enable verbose logging =
(warning/info and above)\n&quot;<br>
=C2=A0&quot;=C2=A0 -g, --debug=C2=A0 =C2=A0 =C2=A0 =C2=A0enable debug loggi=
ng (all messages)\n&quot;<br>
+&quot;=C2=A0 -A, --audit=3DLIST=C2=A0 comma-separated list of command patt=
erns to log at\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 info level (default: *, no spaces).\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Patterns prefixed with &#39;!&#39; are logged at debug level.\n&quot;<b=
r>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Patterns are evaluated in order; the first match wins.\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Example: --audit=3D!guest-ping,*\n&quot;<br>
=C2=A0&quot;=C2=A0 -V, --version=C2=A0 =C2=A0 =C2=A0print version informati=
on and exit\n&quot;<br>
=C2=A0&quot;=C2=A0 -d, --daemonize=C2=A0 =C2=A0become a daemon\n&quot;<br>
=C2=A0#ifdef _WIN32<br>
@@ -413,6 +421,29 @@ static void ga_log(const gchar *domain, GLogLevelFlags=
 level,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void ga_audit_log(GAState *s, const char *command)<br>
+{<br>
+=C2=A0 =C2=A0 GList *l;<br>
+<br>
+=C2=A0 =C2=A0 for (l =3D s-&gt;audit_patterns; l; l =3D l-&gt;next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *pattern =3D l-&gt;data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pattern[0] =3D=3D &#39;!&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_pattern_match_simple(patte=
rn + 1, command)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;%s c=
alled&quot;, command);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_pattern_match_simple(patte=
rn, command)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_info(&quot;%s ca=
lled&quot;, command);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;%s called&quot;, command);<br>
+}<br>
+<br>
=C2=A0void ga_set_response_delimited(GAState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;delimit_response =3D true;<br>
@@ -706,7 +737,22 @@ static void process_event(void *opaque, QObject *obj, =
Error *err)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_debug(&quot;processing command&quot;);<br>
-=C2=A0 =C2=A0 rsp =3D qmp_dispatch(&amp;ga_commands, obj, false, NULL);<br=
>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QDict *dict =3D qobject_to(QDict, obj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *command =3D dict ? qdict_get_try_s=
tr(dict, &quot;execute&quot;) : NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool logging_before =3D ga_logging_enabled(s);=
<br></blockquote><div><br></div><div>Please add a comment on why we need th=
is.</div><div>I know about fs-thaw and disabled logging, but for other peop=
le, this can be unclear=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool audit =3D command &amp;&amp; qmp_find_com=
mand(&amp;ga_commands, command);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (audit) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_audit_log(s, command);<br></b=
lockquote><div>What if command =3D NULL? Is ga_audit_log NULL-safe?=C2=A0</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp =3D qmp_dispatch(&amp;ga_commands, obj, fa=
lse, NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!logging_before &amp;&amp; audit) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_audit_log(s, command);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0end:<br>
=C2=A0 =C2=A0 =C2=A0ret =3D send_response(s, rsp);<br>
@@ -1158,6 +1204,14 @@ static void config_load(GAConfig *config, const char=
 *confpath, bool required)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;retry_path =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_key_file_get_boolean(keyf=
ile, &quot;general&quot;, &quot;retry-path&quot;, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;a=
udit&quot;, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;auditstr =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_get_string(keyfile, &=
quot;general&quot;, &quot;audit&quot;, &amp;gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;audit_patterns =3D g_list_concat(co=
nfig-&gt;audit_patterns,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0g_list_reverse(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(config-&gt;auditstr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;,&quot;)));<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (g_key_file_has_key(keyfile, &quot;general&quot;, &q=
uot;block-rpcs&quot;, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;bliststr =3D<br>
@@ -1230,6 +1284,9 @@ static void config_dump(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;log_level &amp; G_LOG_LEVEL_DEBUG);<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_set_boolean(keyfile, &quot;general&quot;, &q=
uot;retry-path&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;retry_path);<br>
+=C2=A0 =C2=A0 tmp =3D list_join(config-&gt;audit_patterns, &#39;,&#39;);<b=
r>
+=C2=A0 =C2=A0 g_key_file_set_string(keyfile, &quot;general&quot;, &quot;au=
dit&quot;, tmp);<br>
+=C2=A0 =C2=A0 g_free(tmp);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D list_join(config-&gt;blockedrpcs, &#39;,&#39;);=
<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_set_string(keyfile, &quot;general&quot;, &qu=
ot;block-rpcs&quot;, tmp);<br>
=C2=A0 =C2=A0 =C2=A0g_free(tmp);<br>
@@ -1251,7 +1308,7 @@ static void config_dump(GAConfig *config)<br>
<br>
=C2=A0static void config_parse(GAConfig *config, int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdgc:m:p:l:f:F::b:a:s:t:Dr&quot=
;;<br>
+=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdgc:m:p:l:f:F::b:a:A:s:t:Dr&qu=
ot;;<br>
=C2=A0 =C2=A0 =C2=A0int opt_ind =3D 0, ch;<br>
=C2=A0 =C2=A0 =C2=A0const struct option lopt[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;help&quot;, 0, NULL, &#39;h&#39; =
},<br>
@@ -1270,6 +1327,7 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;daemonize&quot;, 0, NULL, &#39;d&=
#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;block-rpcs&quot;, 1, NULL, &#39;b=
&#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;allow-rpcs&quot;, 1, NULL, &#39;a=
&#39; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;audit&quot;, 1, NULL, &#39;A&#39; },<b=
r>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;service&quot;, 1, NULL, &#39;s&#3=
9; },<br>
=C2=A0#endif<br>
@@ -1363,6 +1421,10 @@ static void config_parse(GAConfig *config, int argc,=
 char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(optarg, &quot;,&quot;));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;A&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_list_free_full(config-&gt;audi=
t_patterns, g_free);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;audit_patterns =3D g_=
list_reverse(split_list(optarg, &quot;,&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;s&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;service =3D opta=
rg;<br>
@@ -1417,6 +1479,8 @@ static void config_free(GAConfig *config)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0g_list_free_full(config-&gt;blockedrpcs, g_free);<br>
=C2=A0 =C2=A0 =C2=A0g_list_free_full(config-&gt;allowedrpcs, g_free);<br>
+=C2=A0 =C2=A0 g_list_free_full(config-&gt;audit_patterns, g_free);<br>
+=C2=A0 =C2=A0 g_free(config-&gt;auditstr);<br>
=C2=A0 =C2=A0 =C2=A0g_free(config);<br>
=C2=A0}<br>
<br>
@@ -1460,6 +1524,7 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0g_assert(ga_state =3D=3D NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;log_level =3D config-&gt;log_level;<br>
+=C2=A0 =C2=A0 s-&gt;audit_patterns =3D config-&gt;audit_patterns;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;log_file =3D stderr;<br>
=C2=A0#ifdef CONFIG_FSFREEZE<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;fsfreeze_hook =3D config-&gt;fsfreeze_hook;<br>
@@ -1698,6 +1763,10 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0init_dfl_pathnames();<br>
=C2=A0 =C2=A0 =C2=A0config_parse(config, argc, argv);<br>
<br>
+=C2=A0 =C2=A0 if (config-&gt;audit_patterns =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config-&gt;audit_patterns =3D g_list_append(NU=
LL, g_strdup(&quot;*&quot;));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (config-&gt;pid_filepath =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;pid_filepath =3D g_strdup(dfl_=
pathnames.pidfile);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>
</div>
</blockquote></div>
</blockquote></div></div>

--00000000000006a96d064dc5d524--


